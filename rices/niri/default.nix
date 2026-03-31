{
  delib,
  pkgs,
  homeManagerUser,
  ...
}:
delib.rice {
  name = "niri";

  wallpaper = ../../assets/wallpapers/sunset-birds.png;
  polarity = "dark";

  home = {cfg, ...}: {
    stylix = {
      image = cfg.wallpaper;
      polarity = cfg.polarity;

      base16Scheme = {
        scheme = cfg.name;
        author = homeManagerUser;
        base00 = "011F26";
        base01 = "02303b";
        base02 = "024959";
        base03 = "5C6873";
        base04 = "8a949e";
        base05 = "c4ccd4";
        base06 = "dce2e8";
        base07 = "f0f3f6";
        base08 = "d48878";
        base09 = "e8855a";
        base0A = "d4a84e";
        base0B = "60c888";
        base0C = "5aadad";
        base0D = "EF5766";
        base0E = "7a9ec2";
        base0F = "b85450";
        base10 = "021a22";
        base11 = "031520";
        base12 = "f07878";
        base13 = "f0d070";
        base14 = "90e6ae";
        base15 = "80dede";
        base16 = "ff6e78";
        base17 = "90b8d8";
      };

      opacity = {
        terminal = 0.75;
        applications = 0.93;
        popups = 0.85;
        desktop = 0.6;
      };
    };
  };

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
    matugen.enable = false;
    gui.niri.enable = true;
  };
}
