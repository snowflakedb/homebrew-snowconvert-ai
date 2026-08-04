cask "snowconvert-ai-pr" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake (Preview)"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.38.0-Pr.163"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "866bb82f01351c912f6ace2a377950232191e9e71bc72786a7a1ea8a504fe507"
  else
    sha256 "5f598f18a49baed4b62f88f1b23a665c88dbe7e80ee47ff745ad5a553fe3e53d"
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