#!/usr/bin/env bash
set -euo pipefail

# Parse arguments
CASK_TYPE="${1:-all}"

if [[ "$CASK_TYPE" != "prod" && "$CASK_TYPE" != "beta" && "$CASK_TYPE" != "dev" && "$CASK_TYPE" != "all" ]]; then
  echo "Usage: $0 [prod|beta|dev|all]"
  echo "  prod - Update snowconvert-ai cask (prod environment)"
  echo "  beta - Update snowconvert-ai-pupr cask (beta/staging environment)"
  echo "  dev  - Update snowconvert-ai-dev cask (dev environment)"
  echo "  all  - Update all casks (default)"
  exit 1
fi

# Clean up the environment
ENV="homebrew-tmp-env"

rm -rf "${ENV}"
python3 -m venv "${ENV}"
source "${ENV}/bin/activate"

# Install requirements
pip install -r requirements.txt

# Update cask(s)
if [[ "$CASK_TYPE" == "all" || "$CASK_TYPE" == "prod" ]]; then
  echo "Updating snowconvert-ai (prod)..."
  VERSION_PROD="$(python3 update.py snowconvert-ai.tmpl.rb snowconvert-ai.rb --cask-type prod)"
fi

if [[ "$CASK_TYPE" == "all" || "$CASK_TYPE" == "beta" ]]; then
  echo "Updating snowconvert-ai-pupr..."
  VERSION_BETA="$(python3 update.py snowconvert-ai-pupr.tmpl.rb snowconvert-ai-pupr.rb --cask-type beta)"
fi

if [[ "$CASK_TYPE" == "all" || "$CASK_TYPE" == "dev" ]]; then
  echo "Updating snowconvert-ai-dev..."
  VERSION_DEV="$(python3 update.py snowconvert-ai-dev.tmpl.rb snowconvert-ai-dev.rb --cask-type dev)"
fi

# Remove venv
rm -rf "${ENV}"

echo
echo "Formula update done."
echo
echo "Suggested git commands:"

if [[ "$CASK_TYPE" == "all" ]]; then
  echo "git checkout -b update-casks-${VERSION_PROD:-unknown}"
  echo "git add Casks/snowconvert-ai.rb Casks/snowconvert-ai-pupr.rb Casks/snowconvert-ai-dev.rb"
  echo "git commit -m 'Update casks: snowconvert-ai v${VERSION_PROD:-unknown}, snowconvert-ai-pupr v${VERSION_BETA:-unknown}, snowconvert-ai-dev v${VERSION_DEV:-unknown}'"
  echo "git push origin update-casks-${VERSION_PROD:-unknown}"
elif [[ "$CASK_TYPE" == "prod" ]]; then
  echo "git checkout -b update-snowconvert-ai-${VERSION_PROD}"
  echo "git add Casks/snowconvert-ai.rb"
  echo "git commit -m 'Update snowconvert-ai to v${VERSION_PROD}'"
  echo "git push origin update-snowconvert-ai-${VERSION_PROD}"
elif [[ "$CASK_TYPE" == "beta" ]]; then
  echo "git checkout -b update-snowconvert-ai-pupr-${VERSION_BETA}"
  echo "git add Casks/snowconvert-ai-pupr.rb"
  echo "git commit -m 'Update snowconvert-ai-pupr to v${VERSION_BETA}'"
  echo "git push origin update-snowconvert-ai-pupr-${VERSION_BETA}"
else
  echo "git checkout -b update-snowconvert-ai-dev-${VERSION_DEV}"
  echo "git add Casks/snowconvert-ai-dev.rb"
  echo "git commit -m 'Update snowconvert-ai-dev to v${VERSION_DEV}'"
  echo "git push origin update-snowconvert-ai-dev-${VERSION_DEV}"
fi
