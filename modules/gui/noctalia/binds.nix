{
  delib,
  lib,
  ...
}:
delib.module {
  name = "gui.noctalia";

  myconfig.ifEnabled = let
    noctalia = cmd:
      delib.mkDefaultBindProvider "noctalia" (
        [
          "noctalia"
          "msg"
        ]
        ++ (lib.splitString " " cmd)
      );
  in {
    helpers.binds.actions = {
      # Core
      controlCenter = noctalia "panel-toggle control-center";
      settings = noctalia "settings-toggle";
      sessionMenu = noctalia "panel-toggle session";
      lock = noctalia "session lock";

      # Audio & Brightness
      volumeUp = noctalia "volume-up";
      volumeDown = noctalia "volume-down";
      volumeMute = noctalia "volume-mute";
      brightnessUp = noctalia "brightness-up";
      brightnessDown = noctalia "brightness-down";
    };
  };
}
