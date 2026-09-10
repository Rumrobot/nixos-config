{
  delib,
  host,
  ...
}:
delib.module {
  name = "fonts";

  options = delib.singleEnableOption (host.isDesktop || host.isLaptop);

  nixos.ifEnabled = {myconfig, ...}: {
    fonts.fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [myconfig.rice.fonts.serif.name];
        sansSerif = [myconfig.rice.fonts.sans.name];
        monospace = [myconfig.rice.fonts.monospace.name];
        emoji = [myconfig.rice.fonts.emoji.name];
      };
    };

    fonts.packages = [
      myconfig.rice.fonts.serif.package
      myconfig.rice.fonts.sans.package
      myconfig.rice.fonts.monospace.package
      myconfig.rice.fonts.emoji.package
    ];

    environment.systemPackages = [myconfig.rice.cursor.package];
  };

  home.ifEnabled = {myconfig, ...}: {
    home.pointerCursor = {
      inherit (myconfig.rice.cursor) name package size;
      enable = true;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
