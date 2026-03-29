{
  delib,
  homeManagerUser,
  ...
}: let
  assetsPath = "/home/${homeManagerUser}/nixos-config/assets";
in
  delib.rice {
    name = "hyprland";

    myconfig = {
      gui.hyprpanel.enable = true;
    };

    nixos = {
      services.wallpaper-daemon = {
        enable = true;
        wallpaperDir = "${assetsPath}/wallpapers/25th-hour";
        timezone = "Europe/Copenhagen";
        tool = "swww"; # TODO: Fix code to use awww instead of swww
      };
    };

    home = {
      programs.hyprpanel = {
        settings = {
          layout = {
            bar.layouts = {
              "0" = {
                left = ["dashboard" "workspaces"];
                middle = ["media"];
                right = ["volume" "systray" "notifications"];
              };
            };
          };

          # TODO: Fix wallpaper stuff
          wallpaper.image = "${assetsPath}/wallpapers/25th-hour/1.jpg";

          bar = {
            launcher.autoDetectIcon = true;

            workspaces.spacing = 0.6;

            network = {
              showWifiInfo = true;
              truncation = false;
            };

            clock.format = "%a %d %b  %H:%M:%S";
          };

          menus = {
            dashboard = {
              powermenu.avatar.image = "${assetsPath}/icon.png";
              directories.enabled = false;
            };

            clock = {
              time = {
                military = true;
                hideSeconds = true;
              };
              weather = {
                unit = "metric";
                location = "Copenhagen"; # TODO: Config variable
                key = "";
              };
            };

            media = {
              displayTime = true;
              displayTimeTooltip = true;
            };
          };

          theme = {
            matugen = true;
            matugen_settings.contrast = 0.525;

            tooltip.scaling = 90;
            notification.scaling = 90;
            osd.scaling = 90;

            font = {
              name = "Mononoki Nerd Font Mono";
              size = "16px";
            };

            bar = {
              transparent = true;
              floating = true;

              outer_spacing = "2em";
              buttons = {
                spacing = "0.25em";
                padding_x = "0.7em";
                radius = "0.45em";

                workspaces = {
                  pill.active_width = "8em";
                  pill.radius = "1.9rem * 0.6";
                };
              };
              dropdownGap = "2.75em";
              margin_sides = "0.5em";

              clock.showIcon = false;

              menus = {
                enableShadow = true;

                popover.scaling = 90;
                menu = {
                  dashboard.scaling = 80;
                  volume.scaling = 90;
                  network.scaling = 90;
                  bluetooth.scaling = 90;
                  battery.scaling = 90;
                  clock.scaling = 80;
                  notifications.scaling = 85;
                  dashboard.confirmation_scaling = 90;
                };
              };
            };
          };
        };
      };
    };
  }
