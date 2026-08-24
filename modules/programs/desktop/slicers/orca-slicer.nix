{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.slicers.orca-slicer";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = [pkgs.orca-slicer];

  myconfig.ifEnabled.hardware.networking.ssdp = true;

  nixos.ifEnabled.networking.firewall.allowedUDPPorts = [
    2021 # Bambu Lab SSDP
  ];
}
