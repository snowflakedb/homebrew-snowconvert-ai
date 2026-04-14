cask "snowconvert-ai-dev" do
  name "{{ cask_name }}"
  desc "{{ cask_desc }} (Development Version)"
  homepage "{{ cask_homepage }}"
  version "{{ sc_version }}"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "{{ sc_intel_sha }}"
  else
    sha256 "{{ sc_arm_sha }}"
  end

  url "{{ artifact_repo_base }}/darwin_#{arch_suffix}/{{ environment }}/cli/{{ package_prefix }}-#{version}-darwin-#{arch_suffix}.{{ package_extension }}"

  livecheck do
    url "{{ artifact_repo_base }}/darwin_{{ livecheck_arch }}/{{ environment }}/cli/latest-archive.json"
    strategy :json do |json|
      json["version"]
    end
  end

  binary "{{ package_prefix }}-#{version}/scai"

  # Backward compat: clean up old .pkg installs during upgrade
  uninstall pkgutil: "com.snowflake.snowconvertai.cli"

  caveats <<~EOS
    ⚠️  This is a DEVELOPMENT version of SnowConvert AI CLI
    
    The scai binary has been linked to #{HOMEBREW_PREFIX}/bin/scai
    
    You can now run: scai --help
    
    Note: Development versions may be unstable. For production use:
      brew install --cask snowconvert-ai
  EOS
end
