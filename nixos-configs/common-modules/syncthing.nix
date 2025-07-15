{ config
, pkgs
, ...
}: {
  # SYNCTHING
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "anthony";
  };
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder from syncthing
}
