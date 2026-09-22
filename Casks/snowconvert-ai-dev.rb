cask "snowconvert-ai-dev" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake (Development Version)"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.44.0-rc.296"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "6bde07ac45b7617f63342bd7a90d3ef180e840acd52fcd1d1fdf5a0decf14d3a"
  else
    sha256 "5b1752ac498a6cbb849d59e78dcb85e02d767081453565028426b4a2a823108e"
  end

  url "https://snowconvert.snowflake.com/storage/darwin_#{arch_suffix}/dev/cli/snowflake-scai-cli-#{version}-darwin-#{arch_suffix}.pkg"

  livecheck do
    url "https://snowconvert.snowflake.com/storage/darwin_arm64/dev/cli/latest-mac.yml"
    strategy :electron_builder
  end

  pkg "snowflake-scai-cli-#{version}-darwin-#{arch_suffix}.pkg"
  
  uninstall pkgutil: "com.snowflake.snowconvertai.cli"

  caveats <<~EOS
    ⚠️  This is a DEVELOPMENT version of SnowConvert AI CLI
    
    The scai binary has been installed to /usr/local/snowconvertai/bin/scai
    A symlink has been created at /usr/local/bin/scai for easy access.
    
    You can now run: scai --help
    
    Note: Development versions may be unstable. For production use:
      brew install --cask snowconvert-ai
  EOS
end