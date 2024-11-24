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
    pkgs.starship
  ];

  programs.bash.enable = true; # Active des options pour Bash
  programs.git.enable = true; # Configure Git
  programs.starship.enable = true;

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
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "MichaelAquilina/zsh-you-should-use"; }
        { name = "plugins/git";}
      ];
    };
  };
}
