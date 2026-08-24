{delib, ...}:
delib.module {
  name = "programs.desktop.slicers.bambu-studio";

  options = delib.singleEnableOption false;

  home.ifEnabled.services.flatpak.packages = ["com.bambulab.BambuStudio"];

  myconfig.ifEnabled.hardware.networking.ssdp = true;

  nixos.ifEnabled.networking.firewall.allowedUDPPorts = [
    2021 # Bambu Lab SSDP
  ];
}
