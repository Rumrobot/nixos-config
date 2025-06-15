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
    systemd.user.targets.hyprland-session.Unit.Wants = [
      "xdg-desktop-autostart.target"
    ];

    wayland.windowManager.hyprland = {
      settings = {
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
      extraConfig = ''
        exec-once = "swww init"
        exec-once = "sunpaper -d"
      '';
      enable = true;
      # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
      package = null;
      portalPackage = null;

      systemd.enable = true;
      xwayland = {
        enable = true;
      };
    };
  };
}
