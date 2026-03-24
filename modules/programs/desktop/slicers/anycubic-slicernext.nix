{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.slicers.anycubic-slicernext";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.services.flatpak.packages = [
    rec {
      appId = "com.anycubic.SlicerNext";
      sha256 = "08swdgyy3y40ri8xgwfzcfr5b2n4i5zldvpwzflsnklmnml7z5k9";
      bundle = "${pkgs.fetchurl {
        url = "https://github.com/msax81/AnycubiceSlicerNextFlatpak/releases/download/v1.3.96/AnycubicSlicerNext-1.3.96.flatpak";
        inherit sha256;
      }}";
    }
  ];
}
