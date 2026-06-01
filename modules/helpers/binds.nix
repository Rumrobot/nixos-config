{
  delib,
  host,
  lib,
  ...
}:
delib.module {
  name = "helpers.binds";

  options.helpers.binds = with delib; let
    actionSubmodule = submodule {
      options = {
        bind = strOption "";
        description = strOption "";
        repeat = boolOption true;
        provider = allowNull (strOption null);
        providers = attrsOfOption anything {};
      };
    };
  in {
    enable = boolOption host.guiFeatured;

    keyboard = {
      options = strOption "caps:escape";
    };

    actions = attrsOfOption actionSubmodule {};
  };

  myconfig.ifEnabled = let
    action = bind: description: {
      bind = lib.mkDefault bind;
      inherit description;
    };

    actionNoRepeat = bind: description: {
      bind = lib.mkDefault bind;
      inherit description;
      repeat = false;
    };

    workspaceActions = builtins.listToAttrs (builtins.concatLists (builtins.genList (i: let
        ws = i + 1;
      in [
        {
          name = "workspace${toString ws}";
          value = action "Mod+${toString ws}" "Focus workspace ${toString ws}";
        }
        {
          name = "moveToWorkspace${toString ws}";
          value = action "Mod+Shift+${toString ws}" "Move window to workspace ${toString ws}";
        }
      ])
      9));
  in {
    helpers.binds.actions =
      workspaceActions
      // {
        # Programs
        terminal = action "Mod+Return" "Launch terminal";
        launcher = action "Mod+D" "Open app launcher";
        lock = action "Mod+L" "Lock screen";

        # Shell/Panel
        controlCenter = action "Mod+S" "Toggle control center";
        settings = action "Mod+Comma" "Toggle settings";
        sessionMenu = action "Mod+P" "Toggle session/power menu";

        # Window management
        closeWindow = actionNoRepeat "Mod+Q" "Close active window";
        overview = actionNoRepeat "Mod+Tab" "Toggle overview";
        cycleWindows = action "Alt+Tab" "Cycle windows";

        # Focus
        focusLeft = action "Mod+Left" "Focus left";
        focusDown = action "Mod+Down" "Focus down";
        focusUp = action "Mod+Up" "Focus up";
        focusRight = action "Mod+Right" "Focus right";

        # Move
        moveLeft = action "Mod+Shift+Left" "Move window left";
        moveDown = action "Mod+Shift+Down" "Move window down";
        moveUp = action "Mod+Shift+Up" "Move window up";
        moveRight = action "Mod+Shift+Right" "Move window right";

        # Resize
        resizeShrinkWidth = action "Mod+Ctrl+Left" "Shrink window width";
        resizeShrinkHeight = action "Mod+Ctrl+Down" "Shrink window height";
        resizeGrowHeight = action "Mod+Ctrl+Up" "Grow window height";
        resizeGrowWidth = action "Mod+Ctrl+Right" "Grow window width";

        # Layout
        maximize = action "Mod+F" "Maximize window";
        fullscreen = action "Mod+Shift+F" "Fullscreen window";
        center = action "Mod+C" "Center window";
        consumeWindowLeft = action "Mod+BracketLeft" "Consume or expel window left";
        consumeWindowRight = action "Mod+BracketRight" "Consume or expel window right";

        # Floating
        toggleFloating = action "Mod+Shift+I" "Toggle window floating";
        focusFloating = action "Mod+I" "Switch focus between floating and tiling";

        # Workspaces (sequential)
        workspaceDown = action "Mod+Page_Down" "Focus workspace down";
        workspaceUp = action "Mod+Page_Up" "Focus workspace up";
        moveToWorkspaceDown = action "Mod+Shift+Page_Down" "Move window to workspace down";
        moveToWorkspaceUp = action "Mod+Shift+Page_Up" "Move window to workspace up";

        # Screenshots
        screenshot = action "Print" "Take screenshot";
        screenshotScreen = action "Ctrl+Print" "Screenshot entire screen";
        screenshotWindow = action "Alt+Print" "Screenshot active window";

        # Media
        volumeUp = action "XF86AudioRaiseVolume" "Increase volume";
        volumeDown = action "XF86AudioLowerVolume" "Decrease volume";
        volumeMute = action "XF86AudioMute" "Mute audio output";
        brightnessUp = action "XF86MonBrightnessUp" "Increase brightness";
        brightnessDown = action "XF86MonBrightnessDown" "Decrease brightness";

        # Apps
        passwordManager = action "Ctrl+Shift+Space" "Open password manager";
      };
  };

  nixos.ifEnabled = {cfg, ...}: {
    services.xserver.xkb.options = cfg.keyboard.options;
  };
}
