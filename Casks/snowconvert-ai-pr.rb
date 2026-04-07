cask "snowconvert-ai-pr" do
  name "snowflake-scai-cli"
  desc "AI-powered CLI tool for automated code migration to Snowflake (Preview)"
  homepage "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"
  version "2.18.0-Pr.158"

  arch_suffix = Hardware::CPU.intel? ? "x64" : "arm64"

  if Hardware::CPU.intel?
    sha256 "06921f0a700ce80ee31530abadddf000dc9c5b5616e219dc58336f8d49f0e557"
  else
    sha256 "ebcf54b0e8035852f176d05a1450c35901652cb4297c0d2a14261661f4432037"
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