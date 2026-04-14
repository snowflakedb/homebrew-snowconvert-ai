cask "snowconvert-ai-pr" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake (Preview)"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.20.0"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "abc123def456abc123def456abc123def456abc123def456abc123def456abcd"
  else
    sha256 "789ghi012jkl789ghi012jkl789ghi012jkl789ghi012jkl789ghi012jklmnop"
  end

  url "https://snowconvert.snowflake.com/storage/darwin_#{arch_suffix}/prod/cli/snowflake-scai-cli-#{version}-darwin-#{arch_suffix}.tar.gz"

  livecheck do
    url "https://snowconvert.snowflake.com/storage/darwin_arm64/prod/cli/latest-archive.json"
    strategy :json do |json|
      json["version"]
    end
  end

  binary "snowflake-scai-cli-#{version}/scai"

  # Backward compat: clean up old .pkg installs during upgrade
  uninstall pkgutil: "com.snowflake.snowconvertai.cli"

  caveats <<~EOS
    ⚠️  This is a Preview (PR) version of SnowConvert AI CLI
    
    The scai binary has been linked to #{HOMEBREW_PREFIX}/bin/scai
    
    You can now run: scai --help
    
    Note: Preview versions may contain pre-release features. For production use:
      brew install --cask snowconvert-ai
  EOS
end