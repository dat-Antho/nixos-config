{
  config,
  pkgs,
  ...
}: {
  # Usbmuxd is a daemon that manages connections between iOS devices and a host computer over USB
  services.usbmuxd.enable = true;
}
