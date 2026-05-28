cask "snowconvert-ai-dev" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake (Development Version)"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.28.0-rc.502"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "1472f20e323b540a6c970166309ca46c0efacfb12a3b7ad80d83ca1e98a57cf8"
  else
    sha256 "86a2d7f4d9e6d222e69caf66bb265820f81384b9efe042dd78af679750f256a2"
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