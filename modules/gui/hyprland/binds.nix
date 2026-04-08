{
  delib,
  lib,
  ...
}:
delib.module {
  name = "gui.hyprland";

  myconfig.ifEnabled = let
    hypr = dispatcher: args:
      delib.mkDefaultBindProvider "hyprland" {inherit dispatcher args;};
  in {
    helpers.binds.actions =
      {
        closeWindow = hypr "killactive" "";
        cycleWindows = delib.mkDefaultBindProvider "hyprland" [
          {
            dispatcher = "cyclenext";
            args = "";
          }
          {
            dispatcher = "bringactivetotop";
            args = "";
          }
        ];

        focusLeft = hypr "movefocus" "l";
        focusDown = hypr "movefocus" "d";
        focusUp = hypr "movefocus" "u";
        focusRight = hypr "movefocus" "r";

        moveLeft = hypr "movewindow" "l";
        moveDown = hypr "movewindow" "d";
        moveUp = hypr "movewindow" "u";
        moveRight = hypr "movewindow" "r";

        resizeShrinkWidth = hypr "resizeactive" "-50 0";
        resizeShrinkHeight = hypr "resizeactive" "0 50";
        resizeGrowHeight = hypr "resizeactive" "0 -50";
        resizeGrowWidth = hypr "resizeactive" "50 0";

        maximize = hypr "fullscreen" "1";
        fullscreen = hypr "fullscreen" "0";
        center = hypr "centerwindow" "";
        toggleFloating = hypr "togglefloating" "";
      }
      // builtins.listToAttrs (builtins.concatLists (builtins.genList (i: let
          ws = i + 1;
        in [
          {
            name = "workspace${toString ws}";
            value = hypr "workspace" (toString ws);
          }
          {
            name = "moveToWorkspace${toString ws}";
            value = hypr "movetoworkspace" (toString ws);
          }
        ])
        9));
  };

  home.ifEnabled = {myconfig, ...}: let
    actions = myconfig.helpers.binds.actions;

    parseHyprlandBind = bind: let
      parts = lib.splitString "+" bind;
      lastIdx = builtins.length parts - 1;
      key = builtins.elemAt parts lastIdx;
      mods = lib.sublist 0 lastIdx parts;

      modMap = {
        "Mod" = "SUPER";
        "Ctrl" = "CTRL";
        "Shift" = "SHIFT";
        "Alt" = "ALT";
      };

      hyprMods = map (m: modMap.${m} or m) mods;
    in {
      mods = builtins.concatStringsSep " " hyprMods;
      inherit key;
    };

    mkHyprlandBind = _name: action: let
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
        parsed = parseHyprlandBind action.bind;
      in
        if isCommand
        then "${parsed.mods}, ${parsed.key}, exec, ${builtins.concatStringsSep " " providerData}"
        else "${parsed.mods}, ${parsed.key}, ${providerData.dispatcher}, ${providerData.args or ""}";

    # Handle cycleWindows (multiple dispatchers for one bind)
    cycleAction = actions.cycleWindows;
    hasCycle = cycleAction.provider != null && cycleAction.providers ? ${cycleAction.provider};
    cycleData =
      if hasCycle
      then cycleAction.providers.${cycleAction.provider}
      else null;
    cycleParsed = parseHyprlandBind cycleAction.bind;
    cycleBinds =
      if hasCycle && builtins.isList cycleData
      then map (entry: "${cycleParsed.mods}, ${cycleParsed.key}, ${entry.dispatcher}, ${entry.args or ""}") cycleData
      else [];

    # Other actions
    otherActions = removeAttrs actions ["cycleWindows"];
    otherBinds = builtins.filter (v: v != null) (builtins.attrValues (builtins.mapAttrs mkHyprlandBind otherActions));
  in {
    wayland.windowManager.hyprland.settings.input.kb_options = myconfig.helpers.binds.keyboard.options;
    wayland.windowManager.hyprland.settings.bind = otherBinds ++ cycleBinds;
  };
}
