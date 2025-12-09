#!/usr/bin/env bash
set -euo pipefail

# Clean up the environment
ENV="homebrew-tmp-env"

rm -rf "${ENV}"
python3 -m venv "${ENV}"
source "${ENV}/bin/activate"

# Install requirements
pip install -r requirements.txt

# Update formula
VERSION="$(python3 update.py)"

# Remove venv
rm -rf "${ENV}"

echo
echo "Formula update done."
echo "git checkout -b bump-version-${VERSION}"
echo "git add Casks/snowconvert-ai.rb"
echo "git commit -m 'Update formula to v${VERSION}'"
echo "git push origin bump-version-${VERSION}"
