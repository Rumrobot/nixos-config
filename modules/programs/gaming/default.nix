{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.gaming";

  options = delib.singleEnableOption host.gamingFeatured;

  nixos.ifEnabled = {
    programs.gamemode.enable = true;
  };
}
