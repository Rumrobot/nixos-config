{
  delib,
  homeconfig,
  pkgs,
  ...
}:
delib.module {
  name = "gui.noctalia";

  home.ifEnabled = {myconfig, ...}: {
    # screen-toolkit dependencies
    home.packages = with pkgs;
      [
        grim # screenshots
        slurp # region selection
        hyprpicker
        wl-clipboard
        tesseract
        imagemagick
        zbar # QR/barcode scanning
        curl
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
      ]
      ++ pkgs.lib.optional myconfig.services.kdeconnect.enable sshfs;

    programs.noctalia.settings.plugins = {
      enabled =
        ["alexander/screen-toolkit"]
        ++ pkgs.lib.optional myconfig.services.kdeconnect.enable "icefish/phone-connect";
    };

    programs.noctalia.settings.plugin_settings = {
      "alexander/screen-toolkit" = {
        "record-audio-out" = true;
        "screenshot-path" = homeconfig.xdg.userDirs.pictures;
        "selected-ocr-lang" = "eng+dan";
        "video-path" = homeconfig.xdg.userDirs.videos;
      };
    };
  };
}
