cask "snowconvert-ai" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.19.0"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "3a8d2f6bfcc25468ec64a48b90c9a414c8b9919088217aba9c1d7f4b29f1921b"
  else
    sha256 "254365a6461b52915fa2ba1d34c670dfff834c39e6fd80ffc16d0fbf8a15be6e"
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