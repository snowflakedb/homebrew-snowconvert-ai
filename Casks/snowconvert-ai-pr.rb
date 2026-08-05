cask "snowconvert-ai-pr" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake (Preview)"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.39.1-Pr.11"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "cbd3d83d31957e2debd5b8b983de5e6b06382698abeaf1a7a55bc90633967d77"
  else
    sha256 "b88b146e7a91bc738035b09bb3e8a589b35e7f56536947565b5dafc028f14202"
  end

  url "https://snowconvert.snowflake.com/storage/darwin_#{arch_suffix}/beta/cli/snowflake-scai-cli-#{version}-darwin-#{arch_suffix}.pkg"

  livecheck do
    url "https://snowconvert.snowflake.com/storage/darwin_arm64/beta/cli/latest-mac.yml"
    strategy :electron_builder
  end

  pkg "snowflake-scai-cli-#{version}-darwin-#{arch_suffix}.pkg"
  
  uninstall pkgutil: "com.snowflake.snowconvertai.cli"

  caveats <<~EOS
    ⚠️  This is a Preview (PR) version of SnowConvert AI CLI
    
    The scai binary has been installed to /usr/local/snowconvertai/bin/scai
    A symlink has been created at /usr/local/bin/scai for easy access.
    
    You can now run: scai --help
    
    Note: Preview versions may contain pre-release features. For production use:
      brew install --cask snowconvert-ai
  EOS
end