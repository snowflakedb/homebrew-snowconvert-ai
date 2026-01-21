# homebrew-snowconvert-ai

Homebrew tap for installing SnowConvert AI CLI on macOS.

## Installation

### Stable Version (Recommended)

Install the stable version that automatically uses the latest production or beta release:

```bash
brew tap snowflakedb/snowconvert-ai
brew install --cask snowconvert-ai
```

### Development Version

Install the development version with the latest features (may be unstable):

```bash
brew tap snowflakedb/snowconvert-ai
brew install --cask snowconvert-ai-dev
```

## Usage

After installation, you can use the SnowConvert AI CLI:

```bash
scai --help
```

For complete documentation, tutorials, and guides, visit:
[SnowConvertAI documentation](https://docs.snowflake.com/en/migrations/snowconvert-docs/general/getting-started/README)

## Managing Installations

### View Installed Version

```bash
brew info --cask snowconvert-ai
# or
brew info --cask snowconvert-ai-dev
```

### Switch Between Versions

```bash
# Uninstall current version
brew uninstall --cask snowconvert-ai-dev

# Install the other version
brew install --cask snowconvert-ai
```

### Update to Latest Version

```bash
brew upgrade --cask snowconvert-ai
# or
brew upgrade --cask snowconvert-ai-dev
```

## For Maintainers

<details>
<summary>Cask Development and Maintenance</summary>

### Auto-Detection of Environments

The casks automatically detect which environment to use based on Azure Blob Storage:

- **`snowconvert-ai`** (stable): Uses **prod** if available, falls back to **beta**
- **`snowconvert-ai-dev`**: Always uses **dev** environment

### Updating Casks

Update both casks:
```bash
./update_all_casks.sh
```

Update individual casks:
```bash
python update.py snowconvert-ai.tmpl.rb snowconvert-ai.rb --cask-type prod
python update.py snowconvert-ai-dev.tmpl.rb snowconvert-ai-dev.rb --cask-type dev
```

</details>

## License

See [LICENSE](LICENSE) file for details.
