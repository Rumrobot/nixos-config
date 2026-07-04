{
  delib,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.desktop.music-players";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled = {
    home.packages = with pkgs; [
      spotify
    ];
  };
}
