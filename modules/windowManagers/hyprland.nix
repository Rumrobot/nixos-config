{
  config,
  pkgs,
  pkgs-unstable,
  inputs,
  system,
  lib,
  ...
}: let
  hasNixos = config ? environment;
  hasHome = config ? home;
  cfg = config.nixosConfig.windowManagers.hyprland;
  termPkg = config.nixosConfig.packages.terminal.package;
  termCmd = lib.getExe termPkg;
in {
  options.nixosConfig.windowManagers.hyprland.enable =
    lib.mkEnableOption "Hyprland window manager";

  config = lib.mkMerge [
    (lib.mkIf hasNixos {
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

      environment.sessionVariables.NIXOS_OZONE_WL = "1";

      hardware.graphics = {
        enable = true;
        package = pkgs-unstable.mesa;
      };
    })

    (lib.mkIf hasHome {
      wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        bind =
          [
            "$mod, return, exec, ${termCmd}"
            "$mod, D, exec, rofi -show drun -show-icons"
          ]
          ++ (
            builtins.concatLists (builtins.genList (i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ])
              9)
          );
        input = {
          kb_layout = config.nixosConfig.system.keymap.layout;
        };
      };
    })
  ];
}
