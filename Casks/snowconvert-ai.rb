cask "snowconvert-ai" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.2.3-rc.7"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "4d40b0a0d4d9f31655e5ecf6a262c3bc1a470045ece6d30cdcb1e41edbdbff5a"
  else
    sha256 "915911748e33cc6b50ea28ef678eebdcf6c116a1e3e5ca802bbbd793d8b3e2de"
  end

  url "https://snowconvert.snowflake.com/storage/darwin_#{arch_suffix}/dev/cli/snowflake-scai-cli-#{version}-darwin-#{arch_suffix}.pkg"

  livecheck do
    url "https://snowconvert.snowflake.com/storage/darwin_arm64/dev/cli/latest-mac.yml"
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