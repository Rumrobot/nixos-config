{delib, ...}:
delib.module {
  name = "gui.niri";

  # TODO: Create global bind options to unify binds across WMs

  home.ifEnabled.programs.niri.settings.binds = let
    moveKey = "Shift";
    modifyKey = "Ctrl";

    workspaceBinds = builtins.listToAttrs (builtins.concatLists (builtins.genList (i: let
        ws = i + 1;
      in [
        {
          name = "Mod+${toString ws}";
          value = {action.focus-workspace = ws;};
        }
        {
          name = "Mod+${moveKey}+${toString ws}";
          value = {action.move-column-to-workspace = ws;};
        }
      ])
      9));
  in
    workspaceBinds
    // {
      # Programs
      "Mod+Return".action.spawn = "ghostty"; # TODO: Config variable
      "Mod+D".action.spawn = ["vicinae" "toggle"]; # TODO: Config variable

      # Overview
      "Mod+Tab" = {
        repeat = false;
        action.toggle-overview = [];
      };

      # Window management
      "Mod+Q" = {
        repeat = false;
        action.close-window = [];
      };

      # Focus
      "Mod+Left".action.focus-column-left = [];
      "Mod+Down".action.focus-window-down = [];
      "Mod+Up".action.focus-window-up = [];
      "Mod+Right".action.focus-column-right = [];

      # Move columns/windows
      "Mod+${moveKey}+Left".action.move-column-left = [];
      "Mod+${moveKey}+Down".action.move-window-down = [];
      "Mod+${moveKey}+Up".action.move-window-up = [];
      "Mod+${moveKey}+Right".action.move-column-right = [];

      # Modify windows
      "Mod+${modifyKey}+Left".action.set-column-width = "-5%";
      "Mod+${modifyKey}+Down".action.set-window-height = "-5%";
      "Mod+${modifyKey}+Up".action.set-window-height = "+5%";
      "Mod+${modifyKey}+Right".action.set-column-width = "+5%";

      # Workspaces
      "Mod+Page_Down".action.focus-workspace-down = [];
      "Mod+Page_Up".action.focus-workspace-up = [];
      "Mod+${moveKey}+Page_Down".action.move-column-to-workspace-down = [];
      "Mod+${moveKey}+Page_Up".action.move-column-to-workspace-up = [];

      # Column layout
      "Mod+BracketLeft".action.consume-or-expel-window-left = [];
      "Mod+BracketRight".action.consume-or-expel-window-right = [];
      # "Mod+Comma".action.consume-window-into-column = [];
      # "Mod+Period".action.expel-window-from-column = [];
      # "Mod+R".action.switch-preset-column-width = [];
      "Mod+F".action.maximize-column = [];
      "Mod+Shift+F".action.fullscreen-window = [];
      "Mod+C".action.center-column = [];

      # Floating
      "Mod+I".action.switch-focus-between-floating-and-tiling = [];
      "Mod+${moveKey}+I".action.toggle-window-floating = [];

      # Screenshots
      "Print".action.screenshot = [];
      "Ctrl+Print".action.screenshot-screen = [];
      "Alt+Print".action.screenshot-window = [];
    };
}
