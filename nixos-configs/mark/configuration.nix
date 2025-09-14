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
    ./disk-config.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  networking.hostName = "mark";
  networking.firewall.enable = true;

  system.stateVersion = "24.05";
}
