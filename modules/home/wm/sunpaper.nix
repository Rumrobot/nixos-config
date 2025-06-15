{
  pkgs,
  lib,
  username,
  ...
}: let
  wallpaper = "25th_hour";
  lat = "55.83333N";
  long = "12.33333E";

  swwwFps = "3";
  swwwStep = "3";
in {
  home.packages = with pkgs; [sunpaper jq];

  xdg.dataFile."wallpapers/${wallpaper}".source = ../../../users/${username}/wallpapers/${wallpaper};
  xdg.configFile."sunpaper/config".text = lib.concatStringsSep "\n" [
    ''
      latitude="${lat}"
      longitude="${long}"
      wallpaperPath="$XDG_DATA_HOME/wallpapers/${wallpaper}"
      wallpaperMode="fill"
      swww_enable="true"
      swww_fps="${swwwFps}"
      swww_step="${swwwStep}"
    ''
  ];
}
