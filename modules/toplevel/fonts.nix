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
        serif = [myconfig.rice.fonts.serif.name];
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
}
