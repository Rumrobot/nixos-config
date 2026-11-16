{
  delib,
  host,
  pkgs,
  inputs,
  ...
}:
delib.module {
  name = "programs.gaming.steam";

  options = delib.singleEnableOption host.gamingFeatured;

  nixos.ifEnabled = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
      extraPackages = [pkgs.mangohud];
    };

    programs.gamescope.enable = true;
  };

  home.ifEnabled = {myconfig, ...}: {
    imports = [inputs.steam-config-nix.homeModules.default];

    programs.steam.config = {
      enable = true;

      apps = {
        "526870" = {
          name = "Satisfactory";
          env = {
            PROTON_ENABLE_WAYLAND =
              if myconfig.gui.wayland.enable
              then 1
              else 0;
          };
        };
      };
    };
  };
}
