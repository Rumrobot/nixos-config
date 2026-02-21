{ delib, host, pkgs, ... }:
delib.module {
  name = "programs.desktop.thunar";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled = {
    programs.thunar.enable = true;
  };
}
