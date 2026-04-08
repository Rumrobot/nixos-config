{
  delib,
  lib,
  ...
}:
delib.module {
  name = "gui.noctalia";

  myconfig.ifEnabled = let
    noctalia = cmd:
      delib.mkDefaultBindProvider "noctalia"
      (["noctalia-shell" "ipc" "call"] ++ (lib.splitString " " cmd));
  in {
    helpers.binds.actions = {
      # Core
      controlCenter = noctalia "controlCenter toggle";
      settings = noctalia "settings toggle";
      sessionMenu = noctalia "sessionMenu toggle";
      lock = noctalia "lockScreen lock";

      # Audio & Brightness
      volumeUp = noctalia "volume increase";
      volumeDown = noctalia "volume decrease";
      volumeMute = noctalia "volume muteOutput";
      brightnessUp = noctalia "brightness increase";
      brightnessDown = noctalia "brightness decrease";
    };
  };
}
