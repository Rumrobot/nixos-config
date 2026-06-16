{
  delib,
  assetsPath,
  ...
}:
delib.module {
  name = "gui.noctalia";

  home.ifEnabled = {myconfig, ...}: {
    programs.noctalia-shell.settings = {
      # Bar
      bar = {
        barType = "floating";
        # backgroundOpacity = 0;
        useSeparateOpacity = true;

        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
              icon = "noctalia";
            }
            {
              id = "Spacer";
              width = 2;
            }
            {
              id = "Network";
              displayMode = "onhover";
            }
            {
              id = "Bluetooth";
              displayMode = "onhover";
            }
            {
              id = "Volume";
              displayMode = "onhover";
            }
            {
              id = "Spacer";
              width = 10;
            }
            {
              id = "MediaMini";
              compactMode = true;
              scrollingMode = "hover";
              showArtistFirst = true;
              maxWidth = 175;
              hideMode = "transparent";
              panelShowAlbumArt = true;
              showAlbumArt = true;
              showProgressRing = true;
              showVisualizer = true;
            }
          ];
          center = [
            {
              id = "plugin:kde-connect";
            }
            {
              id = "Workspace";
              hideUnoccupied = false;
              showApplications = true;
              showApplicationsHover = true;
              showBadge = true;
              showLabelsOnlyWhenOccupied = true;
              characterCount = 2;
              labelMode = "index";
              fontWeight = "bold";
              pillSize = 0.6;
              iconScale = 0.8;
              groupedBorderOpacity = 0.7;
            }
            {
              id = "plugin:screen-toolkit";
            }
          ];
          right = [
            {
              id = "Tray";
              blacklist = ["udiskie"];
              drawerEnabled = true;
            }
            {
              id = "NotificationHistory";
              showUnreadBadge = true;
            }
            {
              id = "SystemMonitor";
              compactMode = true;
              useMonospaceFont = true;
              showCpuUsage = true;
              showMemoryUsage = true;
              showCpuTemp = false;
            }
            {
              id = "Battery";
              displayMode = "graphic";
              hideIfNotDetected = true;
              showNoctaliaPerformance = true;
              showPowerProfiles = true;
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              tooltipFormat = "HH:mm - ddd, dd MMM";
            }
          ];
        };
      };

      # General
      general = {
        avatarImage = "${assetsPath}/icon.png";
        autoStartAuth = myconfig.hardware.fingerprint.enable;
        allowPasswordWithFprintd = myconfig.hardware.fingerprint.enable;
        lockScreenAnimations = true;
      };

      # UI
      ui = {
        scrollbarAlwaysVisible = false;
      };

      # Location
      location = {
        showWeekNumberInCalendar = true;
      };

      # Wallpaper
      wallpaper = {
        directory = "${assetsPath}/wallpapers";
        transitionType = [
          "pixelate"
          "honeycomb"
        ];
      };

      # Control Center
      controlCenter = {
        shortcuts = {
          left = [
            {id = "Network";}
            {id = "Bluetooth";}
            {id = "AirplaneMode";}
            {id = "PowerProfile";}
          ];
          right = [
            {id = "Notifications";}
            {id = "KeepAwake";}
            {id = "NightLight";}
            {id = "WallpaperSelector";}
          ];
        };
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = true;
            id = "brightness-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };

      # Dock
      dock = {
        groupApps = true;
      };

      # Session Menu
      sessionMenu = {
        largeButtonsLayout = "grid";
        powerOptions = [
          {
            action = "logout";
            enabled = true;
            keybind = "1";
          }
          {
            action = "suspend";
            enabled = true;
            keybind = "2";
          }
          {
            action = "reboot";
            enabled = true;
            keybind = "3";
            countdownEnabled = true;
          }
          {
            action = "shutdown";
            enabled = true;
            keybind = "4";
            countdownEnabled = true;
          }
        ];
      };

      # Notifications
      notifications = {
        density = "compact";
      };

      # OSD
      osd = {
        location = "right";
      };

      # Audio
      audio = {
        volumeOverdrive = true;
      };
    };
  };
}
