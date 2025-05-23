{ config, pkgs, ... }:
{

  # nix = {
  #   settings = {
  #     substituters = [
  #       "https://datantho-nixos.cachix.org"
  #       "https://cache.nixos.org?priority"
  #       "https://nix-community.cachix.org"
  #     ];
  #     trusted-public-keys = [
  #       "datantho-nixos.cachix.org-1:7mXkZZm1vhW5N0xNuMaYQh/lipZKopDEHXKpcsiDWt8="
  #       "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #     ];
  #   };
  # };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  nix.optimise.automatic = true;
  # keeps the last 5 generations in grub
  boot.loader.systemd-boot.configurationLimit = 5;
  # garbage collection schedule
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };

}
