{
  pkgs,
  username,
  ...
}: let
  wallpaper = "25th_hour";
  lat = "55.83333N";
  long = "12.33333E";
in {
  packages = with pkgs; [sunpaper jq];

  home.file."data/wallpapers/${wallpaper}".source = ./users/${username}/wallpapers/${wallpaper};
  xdg.configFile."sunpaper/config".text = lib.concatStringsSep "\n" [
    ''
      latitude="${lat}"
      longitude="${long}"
      wallpaperPath="$XDG_DATA_HOME/wallpapers/${wallpaper}"
      wallpaperMode="fill"
    ''
  ];
}
