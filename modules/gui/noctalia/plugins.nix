{
  delib,
  homeconfig,
  pkgs,
  lib,
  host,
  homeManagerUser,
  ...
}:
delib.module {
  name = "gui.noctalia";

  nixos.ifEnabled = {
    # piero-93/battery-power-management
    users.groups.battery_ctl = {};
    users.users.${homeManagerUser}.extraGroups = ["battery_ctl"];
    services.udev.extraRules = ''
      ACTION=="add|change", SUBSYSTEM=="power_supply", KERNEL=="BAT*", RUN+="${pkgs.coreutils}/bin/chgrp battery_ctl /sys$devpath/charge_control_end_threshold", RUN+="${pkgs.coreutils}/bin/chmod 0664 /sys$devpath/charge_control_end_threshold"
    '';
  };

  home.ifEnabled = {myconfig, ...}: {
    # screen-toolkit dependencies
    home.packages = with pkgs;
      [
        # alexander/screen-toolkit dependencies
        grim # screenshots
        slurp # region selection
        hyprpicker
        wl-clipboard
        tesseract
        imagemagick
        zbar # QR/barcode scanning
        translate-shell
        wl-screenrec
        wf-recorder
        gpu-screen-recorder
        ffmpeg
        gifski # high-quality GIF encoding
        jq
        bc
        swappy
        satty
        mpv
        gimp
        xdg-utils

        # gustav0ar/drive-health dependencies
        smartmontools

        # nilsonlinux/speedtest-meter dependencies
        ookla-speedtest
      ]
      ++ pkgs.lib.optional myconfig.services.kdeconnect.enable sshfs;

    programs.noctalia.settings = {
      plugins.enabled =
        [
          "alexander/screen-toolkit"
          "gustav0ar/drive-health"
          "nilsonlinux/speedtest-meter"
        ]
        ++ lib.optional myconfig.services.kdeconnect.enable "icefish/phone-connect"
        ++ lib.optional host.isLaptop "piero-93/battery-power-management"
        ++ lib.optional myconfig.services.udiskie.enable "aristides/udiskie";

      plugin_settings = {
        "alexander/screen-toolkit" = {
          "record-audio-out" = true;
          "screenshot-path" = homeconfig.xdg.userDirs.pictures;
          "selected-ocr-lang" = "eng+dan";
          "video-path" = homeconfig.xdg.userDirs.videos;
        };

        "gustav0ar/drive-health" = {
          system_collector_enabled = true;
        };
      };
    };

    # aristides/udiskie
    services.udiskie.settings = {
      notify = false;
      tray = false;
    };
  };

  myconfig.ifEnabled = {
    services.noctalia-drive-health.enable = true;
  };
}
