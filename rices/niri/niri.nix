{delib, ...}:
delib.rice {
  name = "niri";

  home.programs.niri.settings = {
    layout = {
      gaps = 10;
      focus-ring.width = 2;
      border.width = 2;
    };

    window-rules = [
      {
        geometry-corner-radius = let
          r = 16.0;
        in {
          bottom-left = r;
          bottom-right = r;
          top-left = r;
          top-right = r;
        };
        clip-to-geometry = true;
      }
    ];
  };

  myconfig.helpers.binds.actions = {
    consumeWindowLeft.bind = "Mod+aring";
    consumeWindowRight.bind = "Mod+dead_diaeresis";
  };
}
