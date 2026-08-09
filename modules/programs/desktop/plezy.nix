{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.plezy";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [pkgs.plezy];
  };
}
