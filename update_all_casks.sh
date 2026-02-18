#!/bin/bash
set -e

echo "================================================================"
echo "Updating SnowConvert AI Homebrew Casks"
echo "================================================================"

# Update production cask
echo ""
echo "📦 Updating snowconvert-ai (prod)..."
python3 update.py snowconvert-ai.tmpl.rb snowconvert-ai.rb --cask-type prod

# Update beta cask
echo ""
echo "📦 Updating snowconvert-ai-pupr (beta/staging)..."
python3 update.py snowconvert-ai-pupr.tmpl.rb snowconvert-ai-pupr.rb --cask-type beta

# Update development cask
echo ""
echo "📦 Updating snowconvert-ai-dev (development)..."
python3 update.py snowconvert-ai-dev.tmpl.rb snowconvert-ai-dev.rb --cask-type dev

echo ""
echo "================================================================"
echo "✅ All casks updated successfully!"
echo "================================================================"
echo ""
echo "Files updated:"
echo "  - Casks/snowconvert-ai.rb"
echo "  - Casks/snowconvert-ai-pupr.rb"
echo "  - Casks/snowconvert-ai-dev.rb"
