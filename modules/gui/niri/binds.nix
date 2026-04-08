{
  delib,
  lib,
  ...
}:
delib.module {
  name = "gui.niri";

  myconfig.ifEnabled = let
    niri = action: args:
      delib.mkDefaultBindProvider "niri" {inherit action args;};
  in {
    helpers.binds.actions =
      {
        closeWindow = niri "close-window" [];
        overview = niri "toggle-overview" [];

        focusLeft = niri "focus-column-left" [];
        focusDown = niri "focus-window-down" [];
        focusUp = niri "focus-window-up" [];
        focusRight = niri "focus-column-right" [];

        moveLeft = niri "move-column-left" [];
        moveDown = niri "move-window-down" [];
        moveUp = niri "move-window-up" [];
        moveRight = niri "move-column-right" [];

        resizeShrinkWidth = niri "set-column-width" "-5%";
        resizeShrinkHeight = niri "set-window-height" "-5%";
        resizeGrowHeight = niri "set-window-height" "+5%";
        resizeGrowWidth = niri "set-column-width" "+5%";

        maximize = niri "maximize-column" [];
        fullscreen = niri "fullscreen-window" [];
        center = niri "center-column" [];
        consumeWindowLeft = niri "consume-or-expel-window-left" [];
        consumeWindowRight = niri "consume-or-expel-window-right" [];

        toggleFloating = niri "toggle-window-floating" [];
        focusFloating = niri "switch-focus-between-floating-and-tiling" [];

        workspaceDown = niri "focus-workspace-down" [];
        workspaceUp = niri "focus-workspace-up" [];
        moveToWorkspaceDown = niri "move-column-to-workspace-down" [];
        moveToWorkspaceUp = niri "move-column-to-workspace-up" [];

        screenshot = niri "screenshot" [];
        screenshotScreen = niri "screenshot-screen" [];
        screenshotWindow = niri "screenshot-window" [];
      }
      // builtins.listToAttrs (builtins.concatLists (builtins.genList (i: let
          ws = i + 1;
        in [
          {
            name = "workspace${toString ws}";
            value = niri "focus-workspace" ws;
          }
          {
            name = "moveToWorkspace${toString ws}";
            value = niri "move-column-to-workspace" ws;
          }
        ])
        9));
  };

  home.ifEnabled = {myconfig, ...}: let
    actions = myconfig.helpers.binds.actions;

    mkNiriBind = _name: action: let
      hasProvider = action.provider != null && action.providers ? ${action.provider};
      providerData =
        if hasProvider
        then action.providers.${action.provider}
        else null;
    in
      if action.bind == "" || !hasProvider
      then null
      else let
        isCommand = builtins.isList providerData;

        niriAction =
          if isCommand
          then {action.spawn = providerData;}
          else let
            extraKeys = removeAttrs providerData ["action" "args"];
          in
            {action.${providerData.action} = providerData.args;}
            // extraKeys;

        repeatAttr =
          if !action.repeat
          then {repeat = false;}
          else {};
      in {
        name = action.bind;
        value = niriAction // repeatAttr;
      };

    bindEntries = lib.filterAttrs (_: v: v != null) (builtins.mapAttrs mkNiriBind actions);
    niriBind = builtins.listToAttrs (builtins.attrValues bindEntries);
  in {
    programs.niri.settings.input.keyboard.xkb.options = myconfig.helpers.binds.keyboard.options;
    programs.niri.settings.binds = niriBind;
  };
}
