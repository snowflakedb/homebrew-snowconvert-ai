"""
Configuration file for SnowConvertAI CLI Homebrew formula updater.

This file contains all the configuration constants used by the update script.
Separating configuration from logic makes it easier to maintain and update
when environments or URLs change.
"""

# Base URL for the artifact repository (Azure Blob Storage)
ARTIFACT_REPO_BASE = "https://snowconvert.snowflake.com/storage"

# Environment: prod, or dev
ENVIRONMENT = "dev"

# Architecture identifiers
INTEL = "x64"
ARM = "arm64"

# Cask metadata
CASK_NAME = "snowflake-scai-cli"
CASK_DESC = "AI-powered CLI tool for automated code migration to Snowflake"
CASK_HOMEPAGE = "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"

# Package naming
PACKAGE_PREFIX = "snowflake-scai-cli"
PACKAGE_EXTENSION = "pkg"

# Livecheck reference architecture (used to check for new versions)
LIVECHECK_ARCH = "arm64"
