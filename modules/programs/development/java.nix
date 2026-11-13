{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.development.java";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    programs.java = {
      enable = true;
      package = lib.mkDefault pkgs.jdk21;
    };
  };
}
