{ config
, pkgs
, lib
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
        "col.active_border" = lib.mkForce "rgb(d79921)";
        gaps_in = 3;
        gaps_out = 5;
        border_size = 2;

      };
      decoration = {
        rounding = 10;
      };
      input = {
        kb_layout = "us";
        kb_variant = "intl";
      };
      misc = {
        enable_swallow = true;
        swallow_regex = "^(kitty|foot|alacritty|footclient)$";
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
        "$mod,E, exec, dolphin"
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
        "SUPER SHIFT,H, swapwindow, l"
        "SUPER SHIFT,L, swapwindow, r"
        "SUPER SHIFT,K, swapwindow, u"
        "SUPER SHIFT,J, swapwindow, d"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Autostart (Waybar, Mako)
      exec-once = [
        "waybar"
        "mako"
        "swww-daemon &"
        "swww img ~/git/nixos-config/home-manager/common/background3.png"
        "systemctl --user start hyprpolkitagent "
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
          "custom/public-ip"
          "custom/gpu-temp"
          "temperature"
          "battery"
          "pulseaudio"
        ];

        clock = {
          format = "{:%H:%M}";
        };

        network = {
          format = "↑{bandwidthUpOctets} ↓{bandwidthDownOctets}";
          tooltip-format = "{ifname} \nGW: {gwaddr}";
          format-disconnected = "❌ Offline";
          interval = 1;
        };

        battery = {
          format = "{icon}  {capacity}%";
          format-icons = [ "" "" "" "" "" ];
        };

        pulseaudio = {
          format = "  {volume}%";
          pulseaudio = {
            format = "🔊 {volume}%";
            format-muted = "🔇 Muted";
            scroll-step = 5; # Volume step with mouse wheel
            on-click = "pavucontrol"; # Open gui
          };
        };

        tray = {
          icon-size = 16;
          spacing = 10;
        };

        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          format = "CPU: {temperatureC}°C";
          critical-threshold = 90;
          interval = 5;
        };
        "custom/gpu-temp" = {
          exec = "echo -n 'GPU: '; nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits | head -n1 | awk '{print $1\"°C\"}'";
          interval = 5;
          return-type = "text";
        };
        "custom/public-ip" = {
          exec = "curl -L -4 iprs.fly.dev || echo N/A";
          interval = 5;
          return-type = "text";
          format = "🌍 {}";
        };
      }
    ];
    style =
      ''
        @define-color bg-main        #282828;
        @define-color bg-alt         #3c3836;
        @define-color bg-inactive    #504945;
        @define-color bg-focus       #665c54;

        @define-color fg-normal      #ebdbb2;
        @define-color fg-muted       #a89984;
        @define-color fg-warning     #fabd2f;
        @define-color fg-critical    #fb4934;
        @define-color fg-accent      #d79921;
        @define-color fg-success     #98971a;
        @define-color fg-link        #83a598;

        @define-color red            #cc241d;
        @define-color green          #98971a;
        @define-color yellow         #d79921;
        @define-color orange         #fe8019;
        @define-color blue           #458588;
        @define-color purple         #b16286;
        @define-color aqua           #8ec07c;

        * {
          font-family: "JetBrainsMono Nerd Font", "Symbols Nerd Font";
          font-size: 14px;
          font-weight: bold;
          border: none;
          margin: 0;
          padding: 0;
        }

        window#waybar {
          background-color: transparent;
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        /* Modules containers */
        .modules-left,
        .modules-center,
        .modules-right {
          margin: 4px 8px;
          background-color: transparent;
        }

        /* Workspaces */
        #workspaces button {
          padding: 4px 8px;
          margin: 2px;
          color: @fg-muted;
          background: transparent;
          border-radius: 6px;
        }

        #workspaces button.focused {
          background: @bg-focus;
          color: @fg-accent;
        }

        #workspaces button.urgent {
          background: @fg-critical;
          color: @bg-main;
        }

        #workspaces button.active {
          background: @bg-focus;
          color: @fg-normal;
        }

        /* Generic module style */
        #clock,
        #cpu,
        #memory,
        #temperature,
        #disk,
        #battery,
        #network,
        #pulseaudio,
        #custom-microphone,
        #custom-public-ip,
        #custom-gpu-temp,
        #tray {
          padding: 2px 10px;
          margin: 0 4px;
          border-radius: 8px;
          background-color: @bg-inactive;
          color: @fg-normal;
        }

        /* Individual module tweaks */
        #clock {
          color: @fg-accent;
        }

        #cpu,
        #memory {
          color: @fg-normal;
        }

        #temperature {
          color: @fg-normal;
        }

        #disk {
          color: @aqua;
        }

        #battery {
          color: @fg-success;
        }

        #battery.warning:not(.charging) {
          color: @fg-warning;
        }

        #battery.critical:not(.charging) {
          color: @fg-critical;
        }

        #pulseaudio {
          color: @fg-normal;
        }

        #custom-public-ip {
          color: @fg-link;
        }

        #network {
          color: @aqua;
          min-width: 180px; 
        }

        #network.disconnected {
          color: @fg-muted;
        }

        /* Tray icons */
        #tray {
          background-color: @bg-inactive;
          margin: 0 6px;
        }

        #custom-notification {
          color: @yellow;
          padding-right: 8px;
        }
      '';

  };
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
      hyprpolkitagent # allow apps to ask credentials
      pavucontrol
      pamixer # used to detect if mic is on
      pipewire
      pulseaudio
      kdePackages.dolphin
      kdePackages.gwenview

    ];

}
