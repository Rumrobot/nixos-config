{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.nixosConfig.windowManagers.hyprland;
  termPkg = config.nixosConfig.packages.terminal.package;
  termCmd = lib.getExe termPkg;
in {
  options.nixosConfig.windowManagers.hyprland.enable =
    lib.mkEnableOption "Hyprland window manager" // {default = true;};

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      settings = {
        exec-once = [
          "ags run --gtk 4"
          "swww-daemon"
        ];

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
          kb_layout = osConfig.nixosConfig.system.keymap.layout;
        };
      };

      enable = true;
      xwayland.enable = true;

      # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
      package = null;
      portalPackage = null;
    };
  };
}
