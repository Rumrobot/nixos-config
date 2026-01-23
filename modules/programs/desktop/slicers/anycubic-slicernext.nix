{ delib, host, pkgs, ...}:
delib.module {
  name = "programs.desktop.slicers.anycubic-slicernext";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.services.flatpak.packages = [
    rec {
      appId = "com.anycubic.SlicerNext";
      sha256 = "12a8rs0qcwkrp8dbzcsbnwpg71jqaqw6srijpp82zacp8gimr87p";
      bundle = "${pkgs.fetchurl {
        url = "https://github.com/msax81/AnycubiceSlicerNextFlatpak/releases/download/v1.3.995/AnycubicSlicerNext-1.3.995.flatpak";
        inherit sha256;
      }}";
    }
  ];
}
