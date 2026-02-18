import argparse
import hashlib
import os
import requests
from pathlib import Path

import jinja2
import yaml
from config import (
    ARTIFACT_REPO_BASE,
    INTEL,
    ARM,
    CASK_NAME,
    CASK_DESC,
    CASK_HOMEPAGE,
    PACKAGE_PREFIX,
    PACKAGE_EXTENSION,
    LIVECHECK_ARCH
)


class SemVer:
    """Simple semantic version class for comparison"""
    
    def __init__(self, version_str: str):
        parts = version_str.split('.')
        if len(parts) != 3:
            raise ValueError(f"Invalid version format: {version_str}")
        
        self.major = int(parts[0])
        self.minor = int(parts[1])
        self.patch = int(parts[2])
        self.version_str = version_str
    
    def __lt__(self, other):
        return (self.major, self.minor, self.patch) < (other.major, other.minor, other.patch)
    
    def __gt__(self, other):
        return (self.major, self.minor, self.patch) > (other.major, other.minor, other.patch)
    
    def __eq__(self, other):
        return (self.major, self.minor, self.patch) == (other.major, other.minor, other.patch)
    
    def __str__(self):
        return self.version_str


def detect_target_environment(cask_type: str = "prod") -> tuple[str, bool]:
    """
    Detects the correct environment for the cask based on Azure Blob Storage.
    
    For prod cask (snowconvert-ai):
        - Only uses prod (GA versions)
    
    For beta cask (snowconvert-ai-pupr):
        - Always uses beta (staging versions)
    
    For dev cask (snowconvert-ai-dev):
        - Always uses dev
    
    Args:
        cask_type: "prod", "beta", or "dev"
    
    Returns:
        Tuple of (environment_name, exists): 
            - environment_name: "prod", "beta", or "dev"
            - exists: True if the environment has artifacts, False otherwise
    """
    if cask_type in ("dev", "beta"):
        env = cask_type
        try:
            url = f"{ARTIFACT_REPO_BASE}/darwin_arm64/{env}/cli/latest-mac.yml"
            response = requests.get(url, timeout=10)
            if response.status_code == 200:
                return env, True
            else:
                print(f"⚠ {env} environment requested but latest-mac.yml not found (HTTP {response.status_code})")
                return env, False
        except Exception as e:
            print(f"✗ Could not access {env} environment: {e}")
            return env, False
    
    # For prod cask, only check prod environment
    try:
        url = f"{ARTIFACT_REPO_BASE}/darwin_arm64/prod/cli/latest-mac.yml"
        response = requests.get(url, timeout=10)
        
        if response.status_code == 200:
            metadata = yaml.safe_load(response.text)
            version = metadata.get('version', '')
            print(f"✓ Found version {version} in prod environment")
            print(f"→ Using prod environment (GA release)")
            return "prod", True
        else:
            print(f"✗ prod environment not available (HTTP {response.status_code})")
    except Exception as e:
        print(f"✗ Could not access prod: {e}")
    
    print("⚠ No artifacts found in prod environment")
    return "prod", False


def main(template_name: str, file_name: str, cask_type: str = "prod"):
    """
    Updates the cask with the latest available version.
    
    Args:
        template_name: Template file name
        file_name: Output file name
        cask_type: "prod", "beta", or "dev" - determines which environment to use
    """
    # Detect the correct environment
    environment, exists = detect_target_environment(cask_type)
    print(f"\n{'='*60}")
    print(f"Updating {file_name}")
    print(f"Target cask type: {cask_type}")
    print(f"Selected environment: {environment}")
    print(f"{'='*60}\n")
    
    if not exists:
        error_msg = f"❌ Cannot update {file_name}: No artifacts found in {environment} environment"
        print(error_msg)
        raise FileNotFoundError(f"latest-mac.yml not found in {environment} environment at {ARTIFACT_REPO_BASE}/darwin_*/cli/latest-mac.yml")
    
    env = jinja2.Environment(
        loader=jinja2.loaders.FileSystemLoader(Path(__file__).parent)
    )

    template_path = Path(template_name)
    file_path = Path("Casks") / file_name

    template = env.get_template(str(template_path))

    # Fetch latest metadata for both architectures from the detected environment
    metadata_arm = get_yaml_metadata(ARM, environment)
    metadata_intel = get_yaml_metadata(INTEL, environment)

    version_arm = metadata_arm['version']
    version_intel = metadata_intel['version']

    if version_arm != version_intel:
        raise ValueError(f"Latest version ARM ({version_arm}) and Intel ({version_intel}) do not match. Check with RELENG team, and make sure repo is updated")

    # Download packages and calculate SHA256
    sha_for_intel = calculate_sha256_from_pkg(metadata_intel, environment)
    sha_for_arm = calculate_sha256_from_pkg(metadata_arm, environment)

    if not template_path.exists():
        raise ValueError(f"Template file not found: {template}")

    with open(file_path, "w+") as fh:
        fh.write(
            template.render(
                sc_version=version_arm,
                sc_intel_sha=sha_for_intel,
                sc_arm_sha=sha_for_arm,
                environment=environment,
                cask_name=CASK_NAME,
                cask_desc=CASK_DESC,
                cask_homepage=CASK_HOMEPAGE,
                artifact_repo_base=ARTIFACT_REPO_BASE,
                package_prefix=PACKAGE_PREFIX,
                package_extension=PACKAGE_EXTENSION,
                livecheck_arch=LIVECHECK_ARCH,
            )
        )
    print(f"\n✓ Successfully updated {file_name} to version {version_arm}")
    print(version_arm)

def get_yaml_metadata(architecture: str, environment: str) -> dict:
    """Fetch and parse the latest-mac.yml file for the given architecture."""
    url = f"{ARTIFACT_REPO_BASE}/darwin_{architecture}/{environment}/cli/latest-mac.yml"
    response = requests.get(url)
    response.raise_for_status()
    return yaml.safe_load(response.text)

def calculate_sha256_from_pkg(metadata: dict, environment: str) -> str:
    """Download the package and calculate its SHA256 hash."""
    architecture = "arm64" if "arm64" in metadata['path'] else "x64"
    pkg_url = f"{ARTIFACT_REPO_BASE}/darwin_{architecture}/{environment}/cli/{metadata['path']}"
    
    # Download the package
    response = requests.get(pkg_url, stream=True)
    response.raise_for_status()
    
    # Calculate SHA256
    sha256_hash = hashlib.sha256()
    for chunk in response.iter_content(chunk_size=8192):
        sha256_hash.update(chunk)
    
    return sha256_hash.hexdigest()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Update SnowConvert AI formula")
    parser.add_argument(
        "template_path", 
        type=str, 
        nargs='?',
        default="snowconvert-ai.tmpl.rb",
        help="Path to the Jinja2 template file (default: snowconvert-ai.tmpl.rb)"
    )
    parser.add_argument(
        "file_path", 
        type=str, 
        nargs='?',
        default="snowconvert-ai.rb",
        help="Path to the output file (default: snowconvert-ai.rb)"
    )
    parser.add_argument(
        "--cask-type",
        type=str,
        choices=["prod", "dev", "beta"],
        default="prod",
        help="Type of cask: 'prod' (uses prod), 'beta' (uses beta/staging), or 'dev' (uses dev environment)"
    )
    args = parser.parse_args()
    main(args.template_path, args.file_path, args.cask_type)
