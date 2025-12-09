cask "snowconvert-ai" do
  name "{{ cask_name }}"
  desc "{{ cask_desc }}"
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
    url "{{ artifact_repo_base }}/darwin_{{ livecheck_arch }}/{{ environment }}/cli/latest-mac.yml"
    strategy :electron_builder
  end

  auto_updates true

  pkg "{{ package_prefix }}-#{version}-darwin-#{arch_suffix}.{{ package_extension }}"
  
  uninstall pkgutil: "com.snowflake.snowconvertai.cli"

  caveats <<~EOS
    The scai binary has been installed to /usr/local/snowconvertai/bin/scai
    A symlink has been created at /usr/local/bin/scai for easy access.
    
    You can now run: scai --help
  EOS
end
