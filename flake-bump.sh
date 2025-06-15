#!/usr/bin/env bash

set -euo pipefail

echo "🔄 Running flake update..."
nix flake update

echo "🔍 Checking for flake.lock changes..."
if git diff --exit-code flake.lock > /dev/null; then
  echo "✅ No changes to flake.lock."
  exit 0
else
  echo "🚀 flake.lock was updated."
  exit 1
fi

