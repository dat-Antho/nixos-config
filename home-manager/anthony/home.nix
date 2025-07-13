{
  config,
  pkgs,
  ...
}:
{
  home.username = "anthony";
  home.homeDirectory = "/home/anthony";
  home.stateVersion = "24.05";
  home.packages = [
    pkgs.htop
    pkgs.discord
    pkgs.filezilla
    pkgs.keepassxc
    pkgs.obsidian
    pkgs.discord
    pkgs.thunderbird
    pkgs.wget
    pkgs.exfat
    pkgs.rclone
    pkgs.vial
    pkgs.vdhcoapp
    pkgs.tldr
    pkgs.neofetch
    pkgs.lf
    pkgs.calibre
    pkgs.cryptomator
    pkgs.nh
    pkgs.easyeffects
    pkgs.dig
    pkgs.rofi-wayland
    pkgs.libreoffice-still
    pkgs.gh
    pkgs.qFlipper
    pkgs.protonup-qt
    # --- useful to plug phone and get the photos
    pkgs.ifuse
    pkgs.libimobiledevice
    pkgs.gvfs
    # ---
    pkgs.protonvpn-gui
    pkgs.wineWowPackages.stable
    pkgs.teamspeak3
    pkgs.lazygit
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  imports = [
    ./programs
    ../common/programs/git.nix
    ../common/programs/nixvim.nix
    ../common/programs/zoxide.nix
    ../common/programs/mpv.nix
  ];
}
