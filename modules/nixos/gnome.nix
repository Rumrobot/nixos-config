{
  config,
  lib,
  ...
}: let
  cfg = config.nixosConfig.gnome.enable;
in {
  options.nixosConfig.gnome.enable = lib.mkEnableOption "GNOME desktop";

  config = lib.mkIf cfg {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  };
}
