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
      "$mod" = "SUPER";
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
        "$mod,Return, exec, kitty"
        "$mod,T, exec, kitty"
        "$mod,B, exec, firefox"
        "$mod,D, exec, wofi --show drun"
        "$mod,Q, killactive"
        "$mod,M, exit"
        "$mod,1, workspace, 1"
        "$mod,2, workspace, 2"
        "$mod,3, workspace, 3"
        "$mod SHIFT,R, exec, hyprctl, reload"
        "$mod SHIFT,1, movetoworkspace, 1"
        "$mod SHIFT,2, movetoworkspace, 2"
        "$mod SHIFT,3, movetoworkspace, 3"
        "$mod,H, movefocus, l"
        "$mod,L, movefocus, r"
        "$mod,K, movefocus, u"
        "$mod,J, movefocus, d"
        "$mod,V, togglesplit"
        "$mod,F, fullscreen"
        "$mod SHIFT,Space, togglefloating"
      ];

      # Autostart (Waybar, Mako)
      exec-once = [
        "waybar"
        "mako"
        "swww-daemon &"
        "swww img ~/git/nixos-config/home-manager/common/brown_city_planet.jpg"
      ];
    };
  };
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 36;

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "network"
          "cpu"
          "memory"
          "battery"
          "pulseaudio"
        ];

        clock = {
          format = "{:%H:%M}";
        };

        network = {
          format = "{ipaddr} ↑{bandwidthUpOctets} ↓{bandwidthDownOctets}";
          tooltip-format = "{ifname} \nGW: {gwaddr}";
          format-disconnected = "❌ Offline";
          interval = 1;
        };

        cpu = {
          format = "  {usage}%";
        };

        memory = {
          format = "{used:0.1f}G";
        };

        battery = {
          format = "{icon}  {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        pulseaudio = {
          format = "  {volume}%";
        };

        tray = {
          icon-size = 16;
          spacing = 10;
        };
      }
    ];
    # style =
    #   ''
    #       * {
    #         border: none;
    #         border-radius: 0;
    #         font-family: Source Code Pro;
    #       }
    #       window#waybar {
    #         #background: #16191C;
    #         color: #AAB2BF;
    #       }
    #       #workspaces button {
    #         padding: 0 5px;
    #       }
    #     * {
    #       border: none;
    #       border-radius: 0;
    #       padding: 0 6px;
    #       font-family: sans-serif;
    #       font-size: 14px;
    #       background: transparent;
    #       color: #eceff4;
    #     }
    #
    #     window {
    #       background: rgba(22, 22, 22, 0.90);
    #     }
    #
    #     #workspaces button {
    #       color: #eceff4;
    #       background: transparent;
    #       padding: 0 8px;
    #       margin: 0 3px;
    #       border-radius: 4px;
    #     }
    #
    #     #workspaces button.focused {
    #       background: #5e81ac;
    #       color: #2e3440;
    #     }
    #
    #     #clock, #battery, #cpu, #memory, #network, #pulseaudio {
    #       margin: 0 7px;
    #     }
    #
    #     #tray {
    #       margin-left: 10px;
    #     }
    #
    #     #custom-spotify {
    #       color: #1db954;
    #     }
    #
    #     #mode {
    #       background: #bf616a;
    #       color: #fff;
    #       border-radius: 4px;
    #       padding: 0 7px;
    #       margin: 0 7px;
    #     }
    #   '';
    #
  };
  # stylix = {
  #   enable = true;
  #
  #   # Palette Gruvbox Dark Medium
  #   base16Scheme = "gruvbox-dark-medium";
  # };
  # Add rice packages
  home.pointerCursor = {
    gtk.enable = true;
    name = "Adwaita"; # Ou "Breeze", "Bibata-Modern-Ice", "Capitaine Cursors", etc.
    package = pkgs.adwaita-icon-theme;
    size = 50;
  };
  home.packages = with pkgs;
    [
      kitty # Terminal
      mako # Notifications
      grim
      slurp # Screenshots
      swappy # Annotate screenshots
      # should i keep these ?
      papirus-icon-theme
      arc-theme
      lxappearance # Theming tools
      swww
      wofi
      adwaita-icon-theme
    ];

}
