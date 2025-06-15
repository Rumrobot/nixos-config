{
  config,
  pkgs-unstable,
  lib,
  ...
}: let
  cfg = config.nixosConfig.windowManagers.hyprland;
in {
  options.nixosConfig.windowManagers.hyprland.enable =
    lib.mkEnableOption "Hyprland window manager" // {default = true;};

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    # Optional, hint Electron apps to use Wayland:
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    hardware.graphics = {
      enable = true;
      package = pkgs-unstable.mesa;
    };
  };
}
