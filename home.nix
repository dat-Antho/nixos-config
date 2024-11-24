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
    pkgs.wget
    pkgs.starship
    pkgs.glibcLocales
  ];

  programs.bash.enable = true; # Active des options pour Bash
  programs.git = {
    enable = true;
    userEmail = "16465475+dat-Antho@users.noreply.github.com";
    userName = "anthony";
  };
  programs.starship.enable = true;

  programs.newsboat = {
    enable = true;
    autoReload = true;
    browser = "firefox";
    urls = [
      { url = "https://nixos.org/blog/announcements-rss.xml"; }
      { url = "https://www.reddit.com/r/linux_gaming/top/.rss?sort=top&t=week"; }
      { url = "https://www.gamingonlinux.com/article_rss.php"; }
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initExtraFirst = "export LANG=en_US.UTF-8\nexport LC_ALL=en_US.UTF-8";
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
      ];
    };
  };
}
