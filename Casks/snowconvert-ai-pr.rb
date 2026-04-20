cask "snowconvert-ai-pr" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake (Preview)"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.22.0-Pr.29"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "6a33ebb2a9be4827f5935eca5cc9cf3d38ae254d6834a399147327a465f8d3b9"
  else
    sha256 "7c745665fec4677e6036ae7b9ed0a72d4595f537888c5154e7c2c57249846ed2"
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