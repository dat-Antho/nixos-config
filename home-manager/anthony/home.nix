{ config
, pkgs
, ...
}:
{
  home.username = "anthony";
  home.homeDirectory = "/home/anthony";
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    htop
    discord
    filezilla
    keepassxc
    obsidian
    discord
    thunderbird
    wget
    exfat
    rclone
    vial
    vdhcoapp
    tldr
    neofetch
    lf
    fzf
    fd
    calibre
    cryptomator
    nh
    easyeffects
    dig
    libreoffice-still
    gh
    qFlipper
    protonup-qt
    # -- useful to plug phone and get the photos
    ifuse
    libimobiledevice
    gvfs
    # --
    protonvpn-gui
    wineWowPackages.stable
    teamspeak3
    lazygit
    lutris
  ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };


  stylix.targets.kitty.enable = false;
  stylix.targets.nixvim.enable = false;
  imports = [
    ./programs
    ../common/programs/git.nix
    ../common/programs/nixvim.nix
    ../common/programs/zoxide.nix
    ../common/programs/mpv.nix
  ];
}
