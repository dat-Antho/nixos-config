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
    pkgs.libnatpmp
    pkgs.nh
    pkgs.easyeffects
  ];

  imports = [
    ./programs
  ];

}
