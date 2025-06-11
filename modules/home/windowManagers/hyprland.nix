{
  config,
  lib,
  ...
}: let
  cfg = config.nixosConfig.windowManagers.hyprland;
  termPkg = config.nixosConfig.packages.terminal.package;
  termCmd = lib.getExe termPkg;
in {
  options.nixosConfig.windowManagers.hyprland = {
    enable = lib.mkEnableOption "Hyprland window manager";
  };

  config = lib.mkIf cfg.enable {
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
  };
}
