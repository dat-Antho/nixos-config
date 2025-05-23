{ config, pkgs, ... }:

{
  home.username = "anthony";
  home.homeDirectory = "/home/anthony";

  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
  imports = [
	../anthony/programs/nixvim.nix
  ];
  home.packages = [
    pkgs.git
  ];

  home.file.".config/nix/nix.conf".text = ''
  experimental-features = nix-command flakes
  substituters = https://cache.nixos.org https://datantho-nixos.cachix.org
  trusted-users = root anthony
  trusted-public-keys = datantho-nixos.cachix.org-1:7mXkZZm1vhW5N0xNuMaYQh/lipZKopDEHXKpcsiDWt8=
  '';
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  services.syncthing.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
