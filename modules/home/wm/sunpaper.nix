{
  pkgs,
  lib,
  username,
  ...
}: let
  wallpaper = "25th_hour";
  lat = "55.83333N";
  long = "12.33333E";

  swwwFps = 5;
  swwwStep = 5;
in {
  # Add swww support
  nixpkgs.overlays = [
    (self: super: {
      sunpaper = super.sunpaper.overrideAttrs (prev: rec {
        patchPhase =
          prev.patchPhase
          + ''
            substituteInPlace sunpaper.sh --replace 'swww_enable="false"' 'swww_enable="true"'
            substituteInPlace sunpaper.sh --replace 'swww_fps="[0-9]\+"' 'swww_fps="${swwwFps}"'
            substituteInPlace sunpaper.sh --replace 'swww_step="[0-9]\+"' 'swww_step="${swwwStep}"'
          '';
      });
    })
  ];

  home.packages = with pkgs; [sunpaper jq];

  xdg.dataFile."wallpapers/${wallpaper}".source = ../../../users/${username}/wallpapers/${wallpaper};
  xdg.configFile."sunpaper/config".text = lib.concatStringsSep "\n" [
    ''
      latitude="${lat}"
      longitude="${long}"
      wallpaperPath="$XDG_DATA_HOME/wallpapers/${wallpaper}"
      wallpaperMode="fill"
    ''
  ];
}
