{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.gaming.steam";

  options = delib.singleEnableOption host.gamingFeatured;

  nixos.ifEnabled = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };

    programs.gamescope.enable = true;
  };
}
