{delib, ...}:
delib.module {
  name = "services.sddm";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    services.displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };

      settings = {
        Theme = {
          CursorTheme = myconfig.rice.cursor.name;
          CursorSize = myconfig.rice.cursor.size;
        };
      };
    };
  };
}
