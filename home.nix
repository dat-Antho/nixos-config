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
    pkgs.mpv
    pkgs.exfat
    pkgs.rclone
    pkgs.qmk
    pkgs.vial
    pkgs.protonvpn-gui
    pkgs.qbittorrent
    pkgs.vdhcoapp
    pkgs.google-chrome

  ];

  imports = [ ./programs ];
  programs.starship.enable = true;

}
