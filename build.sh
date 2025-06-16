#!/usr/bin/env bash

set -euo pipefail

##################################
# Build Targets Configuration
##################################

NIXOS_TARGETS=("zeno" "aurele" "mark")
HOME_MANAGER_TARGETS=("revan")

##################################
# Cachix Setup
##################################

setup_cachix() {
  if [[ -n "${CACHIX_NAME:-}" && -n "${CACHIX_AUTH_TOKEN:-}" ]]; then
    echo "🔐 Enabling Cachix for $CACHIX_NAME"
    cachix authtoken "$CACHIX_AUTH_TOKEN"
    cachix use "$CACHIX_NAME"
    echo "🚀 Starting Cachix watch-store"
    cachix watch-store "$CACHIX_NAME" &
    export WATCH_PID=$!
  else
    echo "ℹ️ Cachix not enabled (missing environment variables)"
  fi
}

cleanup_cachix() {
  if [[ -n "${WATCH_PID:-}" ]]; then
    echo "🧹 Stopping Cachix watch-store"
    kill -INT "$WATCH_PID"
    wait "$WATCH_PID"
  fi
}


trap cleanup_cachix EXIT

cleanup_store() {
  echo "🧹 Running Nix GC to free disk space"
  nix store gc || true
}

##################################
# Home Manager Build
##################################

build_home_manager() {
  if [[ ${#HOME_MANAGER_TARGETS[@]} -eq 0 ]]; then
    echo "ℹ️ No Home Manager targets defined"
    return
  fi

  echo "🏠 Building Home Manager configurations:"
  local args=()
  for user in "${HOME_MANAGER_TARGETS[@]}"; do
    echo "  🔧 .#homeConfigurations.${user}.activationPackage"
    args+=(".#homeConfigurations.${user}.activationPackage")
  done

  nix build --no-link "${args[@]}"  
  cleanup_store
}

##################################
# NixOS Build 
##################################

build_nixos() {
  if [[ ${#NIXOS_TARGETS[@]} -eq 0 ]]; then
    echo "ℹ️ No NixOS targets defined"
    return
  fi

  for host in "${NIXOS_TARGETS[@]}"; do
    echo "  🔧 Building nixosConfigurations.${host}.config.system.build.toplevel"
    nix build --no-link ".#nixosConfigurations.${host}.config.system.build.toplevel"
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
