{ config
, pkgs
, ...
}: {

  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    systemd.enable = false;
    portalPackage = null;
    settings = {
      general = {
        gaps_in = 6;
        gaps_out = 10;
        border_size = 2;
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
      };
      input = {
        kb_layout = "us";
        kb_variant = "intl";
      };
      animations = {
        enabled = true;
        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
        animation = [
          "windows, 1, 7, myBezier"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Keybindings
      bind = [
        "SUPER,Return, exec, kitty"
        "SUPER,T, exec, kitty"
        "SUPER,B, exec, firefox"
        "SUPER,D, exec, rofi, -show, drun"
        "SUPER,Q, killactive"
        "SUPER,M, exit"
        "SUPER,1, workspace, 1"
        "SUPER,2, workspace, 2"
        "SUPER,3, workspace, 3"
        "SUPER_SHIFT,R, exec, hyprctl, reload"
        "SUPER_SHIFT,1, movetoworkspace, 1"
        "SUPER_SHIFT,2, movetoworkspace, 2"
        "SUPER_SHIFT,3, movetoworkspace, 3"
        "SUPER,H, movefocus, l"
        "SUPER,L, movefocus, r"
        "SUPER,K, movefocus, u"
        "SUPER,J, movefocus, d"
        "SUPER,V, togglesplit"
        "SUPER,F, fullscreen"
        "SUPER_SHIFT,Space, togglefloating"
      ];

      # Autostart (Waybar, Mako)
      exec-once = [
        "waybar"
        "mako"
      ];
    };
  };
  programs.waybar.enable = true; # system bar
  # Add rice packages
  home.packages = with pkgs; [
    kitty # Terminal
    mako # Notifications
    grim
    slurp # Screenshots
    swappy # Annotate screenshots
    # should i keep these ?
    papirus-icon-theme
    arc-theme
    lxappearance # Theming tools
  ];

}
