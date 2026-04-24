cask "snowconvert-ai" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.24.0"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "f4a959bea267e727f752cbb335b5fa2a7947c49d11d295ea910d29b7c569f14b"
  else
    sha256 "4f7b3a37e8779da5ac5368d7b375a3a8bfaaa19bda4bac0c9bd6b6a85f873397"
  end

  url "https://snowconvert.snowflake.com/storage/darwin_#{arch_suffix}/prod/cli/snowflake-scai-cli-#{version}-darwin-#{arch_suffix}.pkg"

  livecheck do
    url "https://snowconvert.snowflake.com/storage/darwin_arm64/prod/cli/latest-mac.yml"
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