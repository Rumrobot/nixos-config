{
  delib,
  inputs,
  host,
  lib,
  homeconfig,
  ...
}:
delib.module {
  name = "stylix";

  # TODO: Dynamic colors that update without relogging.
  #   Would ideally be able to be selected/generated while
  #   running without needing to switch config

  options = delib.singleEnableOption host.guiFeatured;

  nixos.always = {
    imports = [inputs.stylix.nixosModules.stylix];
  };

  nixos.ifEnabled = {myconfig, ...}: {
    stylix = {
      enable = true;

      image = myconfig.rice.wallpaper;

      cursor = {
        inherit (myconfig.rice.cursor) name package size;
      };

      fonts = {
        sansSerif = {
          inherit (myconfig.rice.fonts.sans) name package;
        };
        serif = {
          inherit (myconfig.rice.fonts.serif) name package;
        };
        monospace = {
          inherit (myconfig.rice.fonts.monospace) name package;
        };
        emoji = {
          inherit (myconfig.rice.fonts.emoji) name package;
        };
        sizes = {
          applications = myconfig.rice.fonts.sans.size;
          desktop = myconfig.rice.fonts.sans.size;
          popups = myconfig.rice.fonts.sans.size;
          terminal = myconfig.rice.fonts.monospace.size;
        };
      };
    };
  };

  home.ifEnabled = {myconfig, ...}: {
    stylix.base16Scheme = lib.mkIf myconfig.matugen.enable (let
      themeJson =
        builtins.fromJSON (builtins.readFile
          "${homeconfig.programs.matugen.theme.files}/theme.json");
      b = themeJson.base16;
    in
      {
        scheme = "Matugen";
        author = "Matugen";
      }
      // builtins.listToAttrs (map (n: {
        name = "base0${lib.toUpper n}";
        value = b."base0${n}".default.color;
      }) ["0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "a" "b" "c" "d" "e" "f"]));
  };
}
