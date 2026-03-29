{ delib, ... }:
delib.module {
  name = "gui.hyprland";

  home.ifEnabled.wayland.windowManager.hyprland.settings = {
    bind =
      [
        "SUPER, return, exec, ghostty" # TODO: Config variable
        # "SUPER, D, exec, rofi -show drun -show-icons"
        "SUPER, D, exec, vicinae toggle" # TODO: Config variable
        "Alt, Tab, cyclenext"
        "Alt, Tab, bringactivetotop"
        "SUPER, Q, killactive"
      ]
      ++ (
        builtins.concatLists (builtins.genList (i: let
            ws = i + 1;
          in [
            "SUPER, code:1${toString i}, workspace, ${toString ws}"
            "SUPER SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ])
          9)
      );
  };
}
