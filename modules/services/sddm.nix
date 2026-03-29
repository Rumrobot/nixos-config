{delib, ...}:
delib.module {
  name = "services.sddm";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {myconfig, ...}: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;

      # TODO: Cursor not showing with weston compositor
      settings = {
        Theme = {
          CursorTheme = myconfig.rice.cursor.name;
          CursorSize = myconfig.rice.cursor.size;
        };
      };
    };
  };
}
