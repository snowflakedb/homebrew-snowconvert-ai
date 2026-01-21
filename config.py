"""
Configuration file for SnowConvertAI CLI Homebrew formula updater.

This file contains all the configuration constants used by the update script.
Separating configuration from logic makes it easier to maintain and update
when environments or URLs change.

The environment (prod/beta/dev) is now auto-detected by the update script
based on what's available in Azure Blob Storage.
"""

ARTIFACT_REPO_BASE = "https://snowconvert.snowflake.com/storage"

INTEL = "x64"
ARM = "arm64"

CASK_NAME = "snowflake-scai-cli"
CASK_DESC = "AI-powered CLI tool for automated code migration to Snowflake"
CASK_HOMEPAGE = "https://docs.snowflake.com/en/migrations/snowconvert-docs/overview"

PACKAGE_PREFIX = "snowflake-scai-cli"
PACKAGE_EXTENSION = "pkg"

LIVECHECK_ARCH = "arm64"
