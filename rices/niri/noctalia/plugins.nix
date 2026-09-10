{delib, ...}:
delib.rice {
  name = "niri";

  home = {
    programs.noctalia.settings = {
      plugins.enabled = [
        "0lucasmatheus/awwwall"
      ];

      plugin_settings = {
        "0lucasmatheus/awwwall" = {
          transition_type = "wave";
          filter = "Lanczos3"; # Use "Nearest" for pixelart
        };
      };
    };
  };
}
