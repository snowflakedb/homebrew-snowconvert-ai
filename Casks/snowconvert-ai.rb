cask "snowconvert-ai" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.0.86-rc.22"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "fb8058288b68b381894c2e0cd81fa26ebd92ea47a857b1af13401c32e0607fb7"
  else
    sha256 "c1eda1bc2823975970d0fb1381bf5377c5d229b3563f170ba9f44ea01fcf3681"
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