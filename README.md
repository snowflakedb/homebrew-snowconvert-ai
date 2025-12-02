# homebrew-snowconvert-ai

Homebrew formula allowing for installation of SnowConvert AI using homebrew tap.

## Installation

```bash
brew tap snowflakedb/snowconvert-ai
brew install --cask snowconvert-ai
```

To view information about the installed cask:
```bash
brew info --cask snowconvert-ai
```

## Usage

After installation, you can use the SnowConvert AI CLI:

```bash
scai --help
```

## Development

To update the formula run:
```shell
bash update.sh
```

This will:
1. Fetch the latest version from the artifact repository
2. Read SHA256 checksums from latest-mac.yml metadata files
3. Update the Cask formula with new version and checksums
