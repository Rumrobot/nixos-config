{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "gui.noctalia";

  home.ifEnabled = {myconfig, ...}: {
    # screen-toolkit dependencies
    home.packages = with pkgs; [
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
      ffmpeg
      gifski # high-quality GIF encoding
      jq

      # File picker support
      python3
      python3Packages.pygobject3
      xdg-desktop-portal
    ];

    programs.noctalia-shell.plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        kde-connect = {
          enabled = myconfig.services.kdeconnect.enable;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        screen-toolkit = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
  };
}
