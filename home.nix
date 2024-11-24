{ config, pkgs, ... }:

{
  home.username = "anthony";
  home.homeDirectory = "/home/anthony";

  home.packages = [
    pkgs.git
    pkgs.htop
    #nvim deps
    pkgs.neovim
    pkgs.clang
    pkgs.libgcc
    pkgs.unzip
  ];

  programs.bash.enable = true; # Active des options pour Bash
  programs.git.enable = true;  # Configure Git
}

