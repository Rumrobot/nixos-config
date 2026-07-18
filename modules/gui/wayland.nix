{delib, ...}:
delib.module {
  name = "gui.wayland";

  options = {myconfig, ...}:
    with delib; {
      gui.wayland.enable = boolOption (myconfig.gui.hyprland.enable || myconfig.gui.niri.enable);
    };

  home.ifEnabled = {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
