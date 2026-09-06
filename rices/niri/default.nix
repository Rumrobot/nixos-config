{
  delib,
  homeManagerUser,
  pkgs,
  ...
}:
delib.rice {
  name = "niri";

  wallpaper = ../../assets/wallpapers/sunset-birds.png;
  polarity = "dark";

  cursor = {
    name = "Posy_Cursor_Black";
    package = pkgs.posy-cursors;
    size = 24;
  };

  fonts = {
    sans = {
      name = "Roboto";
      package = pkgs.roboto;
      size = 10;
    };
    serif = {
      name = "Roboto Serif";
      package = pkgs.roboto-serif;
      size = 10;
    };
    monospace = {
      name = "JetBrains Mono";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 12;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-color-emoji;
      size = 14;
    };
  };

  myconfig = {
    gui.niri.enable = true;
    stylix.enable = false;
  };

  home = {
    home.packages = [pkgs.adw-gtk3];

    gtk = {
      enable = true;
      colorScheme = "dark";
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      qt5ctSettings.Appearance = {
        color_scheme_path = "/home/${homeManagerUser}/.config/qt5ct/colors/noctalia.conf";
        custom_palette = true;
        style = "Fusion";
      };
      qt6ctSettings.Appearance = {
        color_scheme_path = "/home/${homeManagerUser}/.config/qt6ct/colors/noctalia.conf";
        custom_palette = true;
        style = "Fusion";
      };
    };
  };
}
