cask "snowconvert-ai" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.2.5-rc.3"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "47a73c8a5a9303ce2e9f270b1f67da2a037c39d98b1e98b37228a22e34fed14b"
  else
    sha256 "3d6a467bd90d0a8a5e256ae07578e0d7b909fbe79dd9cfe5987e4ec04100ff9a"
  end

  url "https://snowconvert.snowflake.com/storage/darwin_#{arch_suffix}/dev/cli/snowflake-scai-cli-#{version}-darwin-#{arch_suffix}.pkg"

  livecheck do
    url "https://snowconvert.snowflake.com/storage/darwin_arm64/dev/cli/latest-mac.yml"
    strategy :electron_builder
  end

  pkg "snowflake-scai-cli-#{version}-darwin-#{arch_suffix}.pkg"
  
  uninstall pkgutil: "com.snowflake.snowconvertai.cli"

  caveats <<~EOS
    The scai binary has been installed to /usr/local/snowconvertai/bin/scai
    A symlink has been created at /usr/local/bin/scai for easy access.
    
    You can now run: scai --help
  EOS
end