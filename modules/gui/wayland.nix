{delib, ...}:
delib.module {
  name = "gui.wayland";

  options = with delib;
    moduleOptions ({myconfig, ...}: {
      enable = boolOption (myconfig.gui.hyprland.enable || myconfig.gui.niri.enable);
    });

  home.ifEnabled = {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
