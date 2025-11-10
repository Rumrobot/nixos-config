{
  config,
  username,
  pkgs-unstable,
  ...
}: let
  terminal = config.environment.sessionVariables.TERMINAL;
  monitors = config.nixosConfig.desktop.monitors;

  # Convert monitor config to Hyprland format
  monitorToHyprland = monitor:
    if monitor.enabled
    then "desc:${monitor.id},${toString monitor.width}x${toString monitor.height}@${toString monitor.refreshRate},${toString monitor.position.x}x${toString monitor.position.y},${toString monitor.scale},transform,${toString monitor.rotation}"
    else "desc:${monitor.id},disable";
in {
  imports = [
    # ./rofi-wayland.nix
    ./vicinae.nix
    ./swww.nix
    ./tui-greet.nix
    ./hyprpanel.nix
  ];

  config = {
    programs.hyprland.enable = true;
    programs.xwayland.enable = true;

    hardware.graphics = {
      enable = true;
      package = pkgs-unstable.mesa;
    };

    home-manager.users.${username} = {
      home.sessionVariables.NIXOS_OZONE_WL = "1";

      services.hyprpolkitagent.enable = true;

      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;

        # Set the Hyprland and XDPH packages to null to use the ones from the NixOS module
        package = null;
        portalPackage = null;

        settings = {
          env = [
            "GRIMBLAST_HIDE_CURSOR, 0"
          ];

          monitor =
            map monitorToHyprland monitors
            ++ [
              ",preffered,auto,1" # Auto
            ];

          exec-once = [
            # "ags run --gtk 4"
            "hyprpanel"
            "swww-daemon"
          ];

          gestures = {
            workspace_swipe = true;
            workspace_swipe_fingers = 3;
            workspace_swipe_distance = 700;
            workspace_swipe_touch = true;

            workspace_swipe_cancel_ratio = 0.2;
            workspace_swipe_min_speed_to_force = 5;
            workspace_swipe_direction_lock = true;
            workspace_swipe_direction_lock_threshold = 10;
            workspace_swipe_create_new = true;
          };

          "$mod" = "SUPER";
          bind =
            [
              "$mod, return, exec, ${terminal}"
              # "$mod, D, exec, rofi -show drun -show-icons"
              "$mod, D, exec, vicinae toggle"
              "Alt, Tab, cyclenext"
              "Alt, Tab, bringactivetotop"
              "$mod, Q, killactive"
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

          layerrule = [
            "blur,vicinae"
            "ignorealpha 0, vicinae"
            # "noanim, vicinae" # Disable fade for vicinae
          ];

          input = {
            kb_layout = config.nixosConfig.system.keymap.layout;
            kb_options = config.nixosConfig.system.keymap.options;

            touchpad = {
              natural_scroll = true;
              disable_while_typing = false;
              clickfinger_behavior = true;
              scroll_factor = 0.5;
            };
          };
        };
      };
    };
  };
}
