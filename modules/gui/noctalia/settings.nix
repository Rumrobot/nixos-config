{
  delib,
  assetsPath,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "gui.noctalia";

  home.ifEnabled = {myconfig, ...}: {
    programs.noctalia.settings = {
      # Bar
      bar.main = {
        margin_edge = 10;
        start = [
          "control-center"
          "network"
          "bluetooth"
          "volume"
          "spacer-large"
          "group:g1"
        ];
        capsule_group = [
          {
            accordion = false;
            accordion_direction = "end";
            border = "";
            enabled = true;
            fill = "surface_variant";
            id = "g1";
            members = [
              "media"
              "audio_visualizer"
            ];
            opacity = 0.0;
            padding = 0.0;
            widget_spacing = 5;
          }
        ];
        center =
          lib.optional myconfig.services.kdeconnect.enable "icefish/phone-connect:bar"
          ++ [
            "workspaces"
            "alexander/screen-toolkit:widget"
          ];
        end = [
          "tray"
          "notifications"
          "cpu"
          "ram"
          "battery"
          "clock"
        ];
      };

      # General
      shell = {
        avatar_path = "${assetsPath}/icon.png";
        clipboard_enabled = false;
        screen_time_enabled = true;
        screen_corners.enabled = true;
        screenshot.remember_last_region = true;
        greeter_sync = lib.mkIf myconfig.services.noctalia-greeter.enable {
          auto_sync = true;
        };
      };
      lockscreen = {
        fingerprint = myconfig.hardware.fingerprint.enable;
      };

      # Location
      control_center.calendar.show_week_numbers = true;
      location.auto_locate = true;

      # Wallpaper
      wallpaper.directory = "${assetsPath}/wallpapers";

      # Control Center
      control_center = {
        shortcuts =
          [
            {type = "wifi";}
            {type = "bluetooth";}
            {type = "power_profile";}
            {type = "notification";}
            {type = "nightlight";}
          ]
          ++ lib.optional myconfig.services.kdeconnect.enable {type = "icefish/phone-connect:tile";};
      };

      # Dock
      dock = {
        enabled = true;
        reserve_space = false;
        smart_auto_hide = true;
      };

      # Session Menu
      shell.session = {
        grid = true;
        actions = [
          {
            action = "logout";
            enabled = true;
            shortcut = "1";
            countdown_seconds = 5;
          }
          {
            action = "suspend";
            enabled = true;
            shortcut = "2";
          }
          {
            action = "reboot";
            enabled = true;
            shortcut = "3";
            countdown_seconds = 10;
          }
          {
            action = "shutdown";
            enabled = true;
            shortcut = "4";
            countdown_seconds = 10;
          }
        ];
      };

      # OSD
      osd = {
        position = "center_right";
        kinds.lock_keys = false;
      };

      # Notifications
      notification.history_retention_hours = 48;

      # Battery
      battery.warning_threshold = 20;

      # Audio
      audio.enable_overdrive = true;

      widget = {
        control-center.custom_image = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        network.show_label = false;
        volume.show_label = false;
        spacer-large.type = "spacer";
        media = {
          artist_first = true;
          max_length = 175;
          title_scroll = "on_hover";
          show_progress = true;
        };
        workspaces = {
          hide_when_empty = false;
          show_labels = true;
          labels_only_when_occupied = true;
          max_label_chars = 2;
          label_source = "id";
        };
        tray = {
          hidden = ["udiskie"];
          drawer = true;
        };
        notifications.hide_when_no_unread = false;
        clock = {
          format = "{:%H:%M}";
          vertical_format = "{:%H %M}";
          tooltip_format = "{:%H:%M:%S - %a, %d/%m}";
        };
      };
    };
  };
}
