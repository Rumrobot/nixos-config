{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.dtu";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      ltspice # Electronics simulator
    ];
  };
}
