#!/usr/bin/env bash

set -euo pipefail

##################################
# Build Targets Configuration
##################################

##################################
# Dynamic Target Discovery
##################################

get_nixos_targets() {
  nix flake show --json | jq -r '.nixosConfigurations | keys[]?'
}

get_hm_targets() {
  nix eval .#homeConfigurations --apply 'builtins.attrNames' --json | jq -r '.[]'
}
##################################
# Cachix Setup
##################################

setup_cachix() {
  if [[ -n "${CACHIX_NAME:-}" && -n "${CACHIX_AUTH_TOKEN:-}" ]]; then
    echo "🔐 Enabling Cachix for $CACHIX_NAME"
    cachix authtoken "$CACHIX_AUTH_TOKEN"
    cachix use "$CACHIX_NAME"
  else
    echo "ℹ️ Cachix not enabled (missing environment variables)"
  fi
}


cleanup_store() {
  echo "🧹 Running Nix GC to free disk space"
  nix store gc || true
}
##################################
# Home Manager Build
##################################

build_home_manager() {
  local targets
  targets=($(get_hm_targets))
  if [[ ${#targets[@]} -eq 0 ]]; then
    echo "ℹ️ No Home Manager targets found"
    return
  fi
  echo "🏠 Building Home Manager configurations:"
  local args=()
  for user in "${targets[@]}"; do
    echo "  🔧 .#homeConfigurations.${user}.activationPackage"
    args+=(".#homeConfigurations.${user}.activationPackage")
  done
  nix build --max-jobs 2 "${args[@]}" --out-link ./result-hm
  nix path-info --recursive ./result-hm | cachix push "$CACHIX_NAME"
  cleanup_store
}

##################################
# NixOS Build 
##################################

build_nixos() {
  local targets
  targets=($(get_nixos_targets))
  if [[ ${#targets[@]} -eq 0 ]]; then
    echo "ℹ️ No NixOS targets found"
    return
  fi
  for host in "${targets[@]}"; do
    echo "  🔧 Building nixosConfigurations.${host}.config.system.build.toplevel"
    nix build --max-jobs 2 ".#nixosConfigurations.${host}.config.system.build.toplevel" --out-link ./result
    nix path-info --recursive ./result | cachix push "$CACHIX_NAME"
    cleanup_store
  done
}


##################################
# Main
##################################

main() {
  echo "🚀 Starting flake build"
  setup_cachix

  SECONDS=0

  build_home_manager
  build_nixos

  duration=$SECONDS
  printf "✅ Build completed in %02d:%02d\n" $((duration/60)) $((duration%60))
}

main
