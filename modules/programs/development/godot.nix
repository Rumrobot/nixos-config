{delib, pkgs, ...}:
delib.module {
  name = "programs.development.godot";

  options = delib.singleEnableOption false;

  home.ifEnabled.home.packages = with pkgs; [godot];
}
