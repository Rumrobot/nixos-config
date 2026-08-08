{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.gaming.steam";

  options = delib.singleEnableOption host.gamingFeatured;

  # Satisfactory needs to use Proton GE with these launch options to work properly on wayland (niri):
  # PROTON_ENABLE_WAYLAND=1 WAYLANDDRV_PRIMARY_MONITOR=DP-2 %command%

  nixos.ifEnabled = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
      extraPackages = [pkgs.mangohud];
    };

    programs.gamescope.enable = true;
  };
}
