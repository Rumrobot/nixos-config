{delib, ...}:
delib.module {
  name = "programs.desktop.slicers.bambu-studio";

  options = delib.singleEnableOption false;

  home.ifEnabled.services.flatpak.packages = ["com.bambulab.BambuStudio"];
}
