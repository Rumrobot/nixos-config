{ config, pkgs, pkgs-unstable, inputs, system, lib, ... }:
let
  cfg = config.nixosConfig.windowManagers.hyprland;
in {
  options.nixosConfig.windowManagers.hyprland.enable =
    lib.mkEnableOption "Hyprland window manager";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${system}.hyprland;
      portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    };

    environment.systemPackages = with pkgs; [
      waybar
      mako
      swww
      rofi-wayland
      kitty
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    hardware = {
      graphics = {
        enable = true;
        package = pkgs-unstable.mesa;
      };
    };
  };
}
