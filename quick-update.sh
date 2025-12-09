#!/usr/bin/env bash
# Quick update script - installs dependencies only if missing
set -euo pipefail

echo "🔄 Updating SnowConvert AI cask..."

# Check if virtual environment exists
if [ ! -d "homebrew-tmp-env" ]; then
    echo "📦 Creating virtual environment..."
    python3 -m venv homebrew-tmp-env
    source homebrew-tmp-env/bin/activate
    pip install -q -r requirements.txt
else
    source homebrew-tmp-env/bin/activate
fi

# Update formula
echo "⚙️  Generating new cask..."
VERSION="$(python3 update.py)"

deactivate

echo ""
echo "✅ Formula updated to v${VERSION}"
echo ""
echo "Next steps:"
echo "  git add Casks/snowconvert-ai.rb"
echo "  git commit -m 'Update formula to v${VERSION}'"
echo "  git push"
