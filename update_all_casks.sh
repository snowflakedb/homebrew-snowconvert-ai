#!/bin/bash
set -e

echo "================================================================"
echo "Updating SnowConvert AI Homebrew Casks"
echo "================================================================"

# Update production cask (auto-detects prod or beta)
echo ""
echo "📦 Updating snowconvert-ai (prod/beta)..."
python3 update.py snowconvert-ai.tmpl.rb snowconvert-ai.rb --cask-type prod

# Update development cask
echo ""
echo "📦 Updating snowconvert-ai-dev (development)..."
python3 update.py snowconvert-ai-dev.tmpl.rb snowconvert-ai-dev.rb --cask-type dev

echo ""
echo "================================================================"
echo "✅ Both casks updated successfully!"
echo "================================================================"
echo ""
echo "Files updated:"
echo "  - Casks/snowconvert-ai.rb"
echo "  - Casks/snowconvert-ai-dev.rb"
