{
  config,
  pkgs,
  ...
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
    calibre
    cryptomator
    nh
    easyeffects
    dig
    rofi-wayland
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
