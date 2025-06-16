#!/usr/bin/env bash

set -euo pipefail

echo "🔄 Running flake update..."
nix flake update

echo "🔍 Checking for flake.lock changes..."
if git diff --exit-code flake.lock > /dev/null; then
  echo "✅ No changes detected"
  echo "changed=false" >> "$GITHUB_OUTPUT"
else
  echo "🚀 flake.lock was updated"
  echo "changed=true" >> "$GITHUB_OUTPUT"
fi

