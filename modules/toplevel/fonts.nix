{
  delib,
  host,
  ...
}:
delib.module {
  name = "fonts";

  options = delib.singleEnableOption host.isDesktop;

  nixos.ifEnabled = {myconfig, ...}: {
    fonts.fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [myconfig.rice.fonts.sans.name];
        sansSerif = [myconfig.rice.fonts.sans.name];
        monospace = [myconfig.rice.fonts.monospace.name];
        emoji = [myconfig.rice.fonts.emoji.name];
      };
    };

    environment.systemPackages = [
      myconfig.rice.fonts.monospace.package
      myconfig.rice.fonts.sans.package
      myconfig.rice.fonts.emoji.package
      myconfig.rice.cursor.package
    ];
  };

  home.ifEnabled = {myconfig, ...}: {
    home.pointerCursor = {
      inherit (myconfig.rice.cursor) name package size;
      gtk.enable = true;
    };
  };
}
