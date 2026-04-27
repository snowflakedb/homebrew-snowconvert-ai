cask "snowconvert-ai-dev" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake (Development Version)"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.24.0-rc.27"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "e150b44ebe8e40964b062486928d590e854944c4f19e28e80c49a1861713ee33"
  else
    sha256 "8734cb558709a730aab0462aec396d10ea4734430539a1cd969cede473749de8"
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