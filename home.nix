{ config, pkgs, ... }:

{

  home.username = "anthony";
  home.homeDirectory = "/home/anthony";
  home.stateVersion = "24.05";
  home.packages = [
    pkgs.git
    pkgs.htop
    pkgs.discord
    pkgs.filezilla
    pkgs.keepassxc
    pkgs.git
    pkgs.htop
    pkgs.obsidian
    pkgs.discord
    pkgs.thunderbird
    pkgs.wget
    pkgs.starship
    pkgs.stremio
  ];

  imports = [
    programs/newsboat.nix
    programs/zsh.nix
    programs/git.nix
    programs/nvim.nix
  ];
  programs.starship.enable = true;

}
