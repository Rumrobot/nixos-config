{ delib, pkgs, ... }:
delib.rice {
  name = "25th-hour";

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
}
