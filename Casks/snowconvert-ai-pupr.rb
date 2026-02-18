cask "snowconvert-ai-pupr" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake (Public Preview)"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.8.0-PuPr.21"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "8c7afee3506ca5167e64957e8c3b3c7426c6ba4eba06a57e690884d6b4f496f3"
  else
    sha256 "2d72843e26e34965ae37b282f5dcb4d60788dd32eeb4df89e7aeaa27faf247a7"
  end

  url "https://snowconvert.snowflake.com/storage/darwin_#{arch_suffix}/beta/cli/snowflake-scai-cli-#{version}-darwin-#{arch_suffix}.pkg"

  livecheck do
    url "https://snowconvert.snowflake.com/storage/darwin_arm64/beta/cli/latest-mac.yml"
    strategy :electron_builder
  end

  pkg "snowflake-scai-cli-#{version}-darwin-#{arch_suffix}.pkg"
  
  uninstall pkgutil: "com.snowflake.snowconvertai.cli"

  caveats <<~EOS
    ⚠️  This is a Public Preview (PuPr) version of SnowConvert AI CLI
    
    The scai binary has been installed to /usr/local/snowconvertai/bin/scai
    A symlink has been created at /usr/local/bin/scai for easy access.
    
    You can now run: scai --help
    
    Note: Public Preview versions may contain pre-release features. For production use:
      brew install --cask snowconvert-ai
  EOS
end