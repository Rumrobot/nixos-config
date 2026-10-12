{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.dtu";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs.development = {
      java.enable = true;
      python.enable = true;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      ltspice # Electronics simulator
      logisim # Digital electronics simulator
    ];
  };
}
