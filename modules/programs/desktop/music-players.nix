{
  delib,
  inputs,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.desktop.music-players";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled = {
    home.packages = [
      inputs.spotifast.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];
  };
}
