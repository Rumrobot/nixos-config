{ delib, host, pkgs, ...}:
delib.module {
  name = "programs.desktop.slicers.bambu-studio";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.services.flatpak.packages = ["com.bambulab.BambuStudio"];
}
