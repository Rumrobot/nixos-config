{
  delib,
  homeManagerUser,
  ...
}: let
  assetsPath = "/home/${homeManagerUser}/nixos-config/assets";
in
  delib.rice {
    name = "niri";

    myconfig = {
      gui.noctalia.enable = true;
    };

    home = {
      # Noctalia theming
      programs.noctalia-shell.settings = {
        # General theming
        general = {
          showScreenCorners = true;
          forceBlackScreenCorners = true;
          scaleRatio = 0.95;
          radiusRatio = 0.6;
          screenRadiusRatio = 0.5;
          clockFormat = "HH\nmm ";
        };

        # UI theming
        ui = {
          translucentWidgets = true;
          panelsAttachedToBar = false;
          settingsPanelMode = "centered";
        };

        # Notification theming
        notifications.backgroundOpacity = 0.65;

        # Stationary wallpaper in overview
        wallpaper.overviewEnabled = false;

        # Dock theming
        dock.backgroundOpacity = 0.75;

        # OSD theming
        osd.backgroundOpacity = 0.25;

        # Audio theming
        audio.spectrumMirrored = false;
      };

      # Wallpaper
      # https://wallhaven.cc/w/e7kpl8
      home.file.".cache/noctalia/wallpapers.json" = {
        text = builtins.toJSON {
          defaultWallpaper = "${assetsPath}/wallpapers/sunset-birds.png";
        };
      };

      # Stationary wallpaper in overview
      programs.niri.settings = {
        layer-rules = [
          {
            matches = [{namespace = "^noctalia-wallpaper*";}];
            place-within-backdrop = true;
          }
        ];

        layout.background-color = "transparent";

        overview.workspace-shadow.enable = false;
      };
    };
  }
