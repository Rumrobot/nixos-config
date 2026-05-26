{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.gparted";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled.environment.systemPackages = [pkgs.gparted];
}
