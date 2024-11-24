{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.neovim
    pkgs.clang
    pkgs.libgcc
    pkgs.unzip
  ];

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
  };
}
