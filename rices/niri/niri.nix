{ delib, ... }:
delib.rice {
  name = "niri";

  home.programs.niri.settings = {
    layout = {
      gaps = 10;
      focus-ring.width = 1.5;
      border.width = 1.5;
    };

    blur = {
      passes = 3; # more passes = stronger blur (default: 3)
      offset = 0.75; # sample distance per pass (default: 3.0)
      noise = 0.03; # grain overlay (default: 0.02)
      saturation = 1.0; # color saturation boost (default: 1.5)
    };

    window-rules = [
      {
        geometry-corner-radius =
          let
            r = 16.0;
          in
          {
            bottom-left = r;
            bottom-right = r;
            top-left = r;
            top-right = r;
          };
        clip-to-geometry = true;
      }

      # Floating Noctalia settings window.
      {
        matches = [
          {
            app-id = "dev.noctalia.Noctalia";
          }
        ];
        open-floating = true;
        default-column-width = {
          fixed = 1080;
        };
        default-window-height = {
          fixed = 850;
        };
      }

      # Apps: blur them all without xray so it looks more realistic.
      {
        background-effect = {
          blur = true;
          xray = false;
        };
      }
    ];

  };

  myconfig.helpers.binds.actions = {
    consumeWindowLeft.bind = "Mod+aring";
    consumeWindowRight.bind = "Mod+dead_diaeresis";
  };
}
