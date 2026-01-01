{ modulesPath
, lib
, pkgs
, ...
}@args:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./modules/fail2ban.nix
    ./modules/teamspeak.nix
    ./modules/openssh.nix
    ./modules/users.nix
    ./modules/radicale.nix
    ./modules/nginx.nix
    ./modules/woodpecker.nix
    ./disk-config.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  systemd.services.dbus-broker.reloadIfChanged = false; # no reload during switch
  ############################
  # Firewall
  ############################
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  networking.hostName = "mark";

  networking.firewall.enable = true;

  system.stateVersion = "24.05";
}
