{ config, pkgs, ... }:

{
  home.username = "anthony";
  home.homeDirectory = "/home/anthony";
  home.stateVersion = "24.05"; 
  home.packages = [
    pkgs.git
    pkgs.htop
    #nvim deps
    pkgs.neovim
    pkgs.clang
    pkgs.libgcc
    pkgs.unzip
    #nvim deps end
    pkgs.discord
    pkgs.filezilla
    pkgs.keepassxc
    pkgs.git
    pkgs.htop
    pkgs.obsidian
    pkgs.discord
    pkgs.thunderbird
    pkgs.newsboat
    pkgs.wget
 
  ];

  programs.bash.enable = true; # Active des options pour Bash
  programs.git.enable = true;  # Configure Git
 
  programs.zsh = {
  enable = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;

  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
  };
  history = {
    size = 10000;
    path = "${config.xdg.dataHome}/zsh/history";
  };
  oh-my-zsh = {
    enable = true;
    plugins = [ "git" "thefuck" ];
    theme = "robbyrussell";
  };
  };
}

