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
      sha256 = "1sgdy0mdm6k34jvvmbkqqnvcannkq0ydn07bs7qh7k0x8kmn69b3";
      bundle = "${pkgs.fetchurl {
        url = "https://github.com/CrealityOfficial/CrealityPrint/releases/download/v7.1.0/CrealityPrint-Linux-flatpak_V7.1.0-Release_x86_64.flatpak";
        inherit sha256;
      }}";
    }
  ];
}
