{delib, ...}:
delib.rice {
  name = "niri";

  nixos = {
    services.displayManager.noctalia-greeter.settings = {
      appearance = {
        hide_logo = true;
        scheme_selector_position = "hidden";
      };
    };
  };
}
