{ delib, host, ... }:
delib.module {
  name = "programs.desktop.hyprland";

  home.ifEnabled.wayland.windowManager.hyprland.settings = {myconfig, ...}: {
    env = [
      "GRIMBLAST_HIDE_CURSOR, 0"
    ];

    monitor = map (
      display:
      let
        resolution = "${toString display.width}x${toString display.height}@${toString display.refreshRate}";
        position = "${toString display.x}x${toString display.y}";
      in
      "${display.name},${if display.enable then "${resolution},${position},1" else "disable"}"
    ) host.displays;

    exec-once = [
      "hyprpanel"
    ];

    gestures = {
      workspace_swipe_distance = 700;
      workspace_swipe_touch = true;

      workspace_swipe_cancel_ratio = 0.2;
      workspace_swipe_min_speed_to_force = 5;
      workspace_swipe_direction_lock = true;
      workspace_swipe_direction_lock_threshold = 10;
      workspace_swipe_create_new = true;
    };

    layerrule = [
      "blur,vicinae"
      "ignorealpha 0, vicinae"
      # "noanim, vicinae" # Disable fade for vicinae
    ];

    input = {
      kb_layout = "dk"; # TODO: Config variable
      kb_options = "caps:escape"; # TODO: Config variable

      touchpad = {
        natural_scroll = true;
        disable_while_typing = false;
        clickfinger_behavior = true;
        scroll_factor = 0.5;
      };
    };
  };
}
