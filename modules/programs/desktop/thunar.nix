{delib, ...}:
delib.module {
  name = "programs.desktop.thunar";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    programs.thunar.enable = true;
  };
}
