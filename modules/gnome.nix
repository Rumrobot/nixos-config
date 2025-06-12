{
  config,
  lib,
  ...
}: let
  hasNixos = config ? environment;
in {
  options.nixosConfig.gnome.enable = lib.mkEnableOption "GNOME desktop";

  config = lib.mkMerge [
    (lib.mkIf hasNixos {
      services.xserver.enable = true;
      services.xserver.displayManager.gdm.enable = true;
      services.xserver.desktopManager.gnome.enable = true;
    })
  ];
}
