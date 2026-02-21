{ delib, host, pkgs, ... }:
delib.module {
  name = "programs.desktop.networking.angry-ip-scanner";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.angryipscanner];
}
