# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  options,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nixos-modules/nvidia.nix # everything nvidia
  ];

  nix = {
    settings = {
      substituters = [
        "https://datantho-nixos.cachix.org?priority=1"
        "https://cache.nixos.org?priority=2"
        "https://nix-community.cachix.org?priority=3"
      ];
      trusted-public-keys = [
        "datantho-nixos.cachix.org-1:7mXkZZm1vhW5N0xNuMaYQh/lipZKopDEHXKpcsiDWt8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/nvme0n1p1";
  # Use latest zen kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;
  # Enable OpenGL
  hardware.graphics.enable = true;
  hardware.keyboard.qmk.enable = true;

  time.timeZone = "Europe/Amsterdam";
  services.ntp.enable = true;
  networking.timeServers = options.networking.timeServers.default ++ [ "0.fr.pool.ntp.org" ];
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # FLATPAK
  services.flatpak.enable = true;

  # STEAM 
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
  ];
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };


  # RANDOM PROGRAMS
  programs.localsend.enable = true; # airdrop alternative
  programs.gamemode.enable = true;
  programs.partition-manager.enable = true;
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "intl";
  services.xserver.xkb.options = "compose:ralt";
  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anthony = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    initialPassword = "test";
    packages = with pkgs; [
      firefox
      tree
      protonup
      keepassxc
      steam-run
    ];
  };
    fonts.packages = [
    # (
    #     # ⓘ install the following nerd fonts onto the system
    #     pkgs.nerdfonts.override {
    #         fonts = [
    #             "JetBrainsMono"
    #         ];
    #     }
    # )
    # use instead :
    pkgs.nerd-fonts.jetbrains-mono
  ];


  # SYNCTHING
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "anthony";
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder from syncthing


  programs.zsh.enable = true;
  users.users.anthony.shell = pkgs.zsh;

  nix.optimise.automatic = true;
  # keeps the last 5 generations in grub
  boot.loader.systemd-boot.configurationLimit = 5;
  # garbage collection schedule
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # network
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];
  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
