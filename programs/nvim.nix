{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      clang
      clang-tools
      gnumake
      nodejs
      wl-clipboard
      xclip
      libgcc
      unzip
      lua-language-server
      python311Packages.python-lsp-server
    ];
  };
}
