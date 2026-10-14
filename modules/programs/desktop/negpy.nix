{
  delib,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "programs.desktop.negpy";

  options = delib.singleEnableOption false;

  home.ifEnabled.home.packages = [inputs.negpy.packages.${pkgs.stdenv.hostPlatform.system}.default];
}
