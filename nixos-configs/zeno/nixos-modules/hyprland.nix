{ config
, pkgs
, ...
}: {
  environment.systemPackages = with pkgs; [
    hyprland # Wayland compositor
    waybar # Status bar
    kitty # Terminal emulator
    grim # Screenshots
    slurp # Select regions for screenshots
    mako # Notifications
    swappy # Annotate screenshots
    xwayland
  ];

  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
}
