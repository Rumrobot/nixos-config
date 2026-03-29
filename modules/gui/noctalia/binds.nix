{
  delib,
  pkgs,
  ...
}: let
  noctalia = key: cmd: {
    name = key;
    value.action.spawn =
      ["noctalia-shell" "ipc" "call"]
      ++ (pkgs.lib.splitString " " cmd);
  };
in
  delib.module {
    name = "gui.noctalia";

    home.ifEnabled.programs.niri.settings.binds = builtins.listToAttrs [
      # Core
      (noctalia "Mod+S" "controlCenter toggle")
      (noctalia "Mod+Comma" "settings toggle")
      (noctalia "Mod+P" "sessionMenu toggle")
      (noctalia "Mod+L" "lockScreen lock")

      # Audio & Brightness
      (noctalia "XF86AudioRaiseVolume" "volume increase")
      (noctalia "XF86AudioLowerVolume" "volume decrease")
      (noctalia "XF86AudioMute" "volume muteOutput")
      (noctalia "XF86MonBrightnessUp" "brightness increase")
      (noctalia "XF86MonBrightnessDown" "brightness decrease")
    ];
  }
