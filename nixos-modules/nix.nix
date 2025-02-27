{ config, pkgs, ... }:
{

  nix = {
    settings = {
      substituters = [
        "https://datantho-nixos.cachix.org?priority=1"
        "https://cache.nixos.org?priority=2"
      ];
      trusted-public-keys = [
        "datantho-nixos.cachix.org-1:7mXkZZm1vhW5N0xNuMaYQh/lipZKopDEHXKpcsiDWt8="
      ];
    };
  };
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
