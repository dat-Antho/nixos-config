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
    pkgs.obsidian
    pkgs.discord
    pkgs.thunderbird
    pkgs.wget
    pkgs.mpv
    pkgs.exfat
    pkgs.rclone
    pkgs.vial
    pkgs.protonvpn-gui
    pkgs.qbittorrent
    pkgs.vdhcoapp
    pkgs.tldr
    pkgs.neofetch
    pkgs.lf
    pkgs.epy
    pkgs.calibre
    pkgs.cryptomator
    pkgs.nh
    pkgs.easyeffects
    pkgs.dig
    pkgs.rofi-wayland
    pkgs.libreoffice-still
    pkgs.gh
    pkgs.qFlipper
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  imports = [
    ./programs
  ];

}
