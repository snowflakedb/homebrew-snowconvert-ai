cask "snowconvert-ai-dev" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake (Development Version)"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.44.0-rc.245"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "0d6bea2ef99b3e50b2412df694ab3ff7512593dc29f913df2eafc15312cf914d"
  else
    sha256 "f86682b992a0c3e388c8669755afa46bbf2356e0e09148cbd20af60bd5466697"
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