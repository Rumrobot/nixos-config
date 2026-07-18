{delib, ...}:
delib.module {
  name = "services.gnome-keyring";

  options = with delib;
    moduleOptions ({myconfig, ...}: {
      enable = boolOption myconfig.gui.wayland.enable;
    });

  nixos.ifEnabled = {
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
  };
}
