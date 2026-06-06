{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.slicers.crealityprint";

  options = delib.singleEnableOption false;

  home.ifEnabled.services.flatpak.packages = [
    rec {
      appId = "io.github.crealityofficial.CrealityPrint";
      sha256 = "1wv6v0283sxr43n0wb2d2ck6cks1p2wfbrl8k1f8imz22imcgj7i";
      bundle = "${pkgs.fetchurl {
        url = "https://github.com/CrealityOfficial/CrealityPrint/releases/download/v7.0.0/CrealityPrint-Linux-flatpak_V7.0.0-Release_x86_64.flatpak";
        inherit sha256;
      }}";
    }
  ];
}
