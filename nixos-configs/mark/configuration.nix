{
  modulesPath,
  lib,
  pkgs,
  ...
} @ args:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ../common-modules/nix.nix
    ../common-modules/syncthing.nix
    ../common-modules/ntp.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];
  networking.hostName = "mark";
  networking.firewall.enable = true;
  services.fail2ban.enable = true;
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      UseDns = true;
      X11Forwarding = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };
  users.users.anthony = {
    isNormalUser  = true;
    home  = "/home/anthony";
    description  = "Anthony";
    extraGroups  = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys  = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDKytH/92Mx12mQsqIjHdk5FE4yojzh4XGzdOkTnFz9Ft3no29XtflNFDtZw97LeEVRB9ZFAtmHtw7phNEfD/gExg9OwjOHY8MMLFNcUTwS7rDuxo9MSqEPkqvUKn1JyjKMkXPGvwEoAnxxT+ITrAkx0CGlN44a5is9KNIp0b9njD7aY8hdbwELFGl+WgIfDHw2/DZaOWsIKStgRTsoh5FLllGu8UxM6UhRqLWKA2R4a3ojA/ggKurHg6dLM6Od2QAW+NjWhdMf1VYiByDs4sc0cbCYpwvDRznUa1+EqTlE0OuKt85ECSFbKWxdgq/z53L9bjWtl0lV05R4b0hF1t9abSmplwu0PlDDPXMyyFPNFTY12o+g40fBH0lzyu9L5rEVvF9tkGd7ZOczXzuU0eU7QLysQjpWTYoLJAuLD9FBQc1TwbD2B9uKEdd3oeRml6pAAV4wq9nBVP1wFzdbH/yqofjHjtpFgoGM9qW0KzNsCNldK+AKeqWHeGNxHVIfMuQs+pAIJYuP31iw6y2xK0ZaxNHgZVj9f8lQEScEKuAE1t/qUMup+qEYl8kMWzjicCFdsj2mm527uP1cIl9TXEpo8WezwzQU3Y4EuncrziQetwhhpBU2chi+s5la0KQUbwS8ylJRsgH+KODjWBOczfnXXK8tK918R80r6pBm+CI+EQ== " ];
  };
  users.users.root.openssh.authorizedKeys.keys =
  [
    # change this to your ssh key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDKytH/92Mx12mQsqIjHdk5FE4yojzh4XGzdOkTnFz9Ft3no29XtflNFDtZw97LeEVRB9ZFAtmHtw7phNEfD/gExg9OwjOHY8MMLFNcUTwS7rDuxo9MSqEPkqvUKn1JyjKMkXPGvwEoAnxxT+ITrAkx0CGlN44a5is9KNIp0b9njD7aY8hdbwELFGl+WgIfDHw2/DZaOWsIKStgRTsoh5FLllGu8UxM6UhRqLWKA2R4a3ojA/ggKurHg6dLM6Od2QAW+NjWhdMf1VYiByDs4sc0cbCYpwvDRznUa1+EqTlE0OuKt85ECSFbKWxdgq/z53L9bjWtl0lV05R4b0hF1t9abSmplwu0PlDDPXMyyFPNFTY12o+g40fBH0lzyu9L5rEVvF9tkGd7ZOczXzuU0eU7QLysQjpWTYoLJAuLD9FBQc1TwbD2B9uKEdd3oeRml6pAAV4wq9nBVP1wFzdbH/yqofjHjtpFgoGM9qW0KzNsCNldK+AKeqWHeGNxHVIfMuQs+pAIJYuP31iw6y2xK0ZaxNHgZVj9f8lQEScEKuAE1t/qUMup+qEYl8kMWzjicCFdsj2mm527uP1cIl9TXEpo8WezwzQU3Y4EuncrziQetwhhpBU2chi+s5la0KQUbwS8ylJRsgH+KODjWBOczfnXXK8tK918R80r6pBm+CI+EQ== "
  ] ++ (args.extraPublicKeys or []); # this is used for unit-testing this module and can be removed if not needed

  system.stateVersion = "24.05";
}
