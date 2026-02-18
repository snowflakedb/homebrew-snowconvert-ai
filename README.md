# homebrew-snowconvert-ai

Homebrew tap for installing SnowConvert AI CLI on macOS.

## Installation

### Stable Version (Recommended)

Install the stable production (GA) release:

```bash
brew tap snowflakedb/snowconvert-ai
brew install --cask snowconvert-ai
```

### Public Preview Version

Install the Public Preview (PuPr) version with pre-release features from the beta/staging environment:

```bash
brew tap snowflakedb/snowconvert-ai
brew install --cask snowconvert-ai-pupr
```

### Development Version

Install the development version with the latest features (may be unstable):

```bash
brew tap snowflakedb/snowconvert-ai
brew install --cask snowconvert-ai-dev
```

## Usage

After installation, you can use the SnowConvert AI CLI:

```bash
scai --help
```

For complete documentation, tutorials, and guides, visit:
[SnowConvertAI documentation](https://docs.snowflake.com/en/migrations/snowconvert-docs/general/getting-started/README)

## Managing Installations

### View Installed Version

```bash
brew info --cask snowconvert-ai
# or
brew info --cask snowconvert-ai-pupr
# or
brew info --cask snowconvert-ai-dev
```

### Switch Between Versions

```bash
# Uninstall current version
brew uninstall --cask snowconvert-ai-dev

# Install another version
brew install --cask snowconvert-ai
# or
brew install --cask snowconvert-ai-pupr
```

### Update to Latest Version

**Important:** You must run `brew update` first to sync the tap with the latest cask definitions:

```bash
# Update tap definitions and upgrade to latest version
brew update && brew upgrade --cask snowconvert-ai

# For public preview version
brew update && brew upgrade --cask snowconvert-ai-pupr

# For dev version
brew update && brew upgrade --cask snowconvert-ai-dev
```

> **Why both commands?** `brew update` synchronizes your local tap with the latest cask definitions from GitHub. Without it, `brew upgrade` won't see new versions even if they exist on the server.

## For Maintainers

<details>
<summary>Cask Development and Maintenance</summary>

### Available Casks

| Cask | Environment | Description |
|------|-------------|-------------|
| `snowconvert-ai` | **prod** | GA (General Availability) release |
| `snowconvert-ai-pupr` | **beta** | Public Preview / staging release |
| `snowconvert-ai-dev` | **dev** | Development build (may be unstable) |

### Environment Detection

Each cask maps to a fixed environment — there is no fallback logic:

- **`snowconvert-ai`** → uses only **prod** (GA versions)
- **`snowconvert-ai-pupr`** → uses only **beta** (staging/Public Preview versions)
- **`snowconvert-ai-dev`** → uses only **dev** (development versions)

The update script fetches `latest-mac.yml` from Azure Blob Storage for each environment to detect the latest version and SHA256 hashes.

### Updating Casks

#### Update all casks at once

```bash
./update_all_casks.sh
```

#### Update with virtual environment setup (recommended)

The `update.sh` script creates a temporary virtual environment, installs dependencies, and updates casks:

```bash
# Update all casks
./update.sh all

# Update only one environment
./update.sh prod
./update.sh beta
./update.sh dev
```

#### Update individual casks manually

```bash
python update.py snowconvert-ai.tmpl.rb snowconvert-ai.rb --cask-type prod
python update.py snowconvert-ai-pupr.tmpl.rb snowconvert-ai-pupr.rb --cask-type beta
python update.py snowconvert-ai-dev.tmpl.rb snowconvert-ai-dev.rb --cask-type dev
```

### CI/CD Automation

The repository includes GitHub Actions workflows:

- **Update Homebrew Cask** (`check-update-cask.yml`): Runs hourly to check for new versions. When a new version is detected, it creates a branch and pushes changes automatically. Can also be triggered manually for a specific cask type (prod, beta, dev, or all).
- **PR Lint** (`pr-lint.yaml`): Validates cask Ruby syntax and runs `brew audit` on every PR and push.
- **PR Draft** (`pr-draft.yaml`): Automatically adds/removes a "DO NOT MERGE" label on draft PRs.

### Project Structure

| File/Dir | Purpose |
|----------|---------|
| `Casks/*.rb` | Generated cask definitions (do not edit manually) |
| `*.tmpl.rb` | Jinja2 templates used to generate casks |
| `update.py` | Main update script — fetches metadata, downloads packages, computes SHA256, renders templates |
| `update.sh` | Wrapper script with venv setup and per-environment control |
| `update_all_casks.sh` | Quick script to update all three casks at once |
| `config.py` | Configuration constants (URLs, package names, architectures) |
| `requirements.txt` | Python dependencies (`jinja2`, `requests`, `pyyaml`) |

</details>

## License

See [LICENSE](LICENSE) file for details.
