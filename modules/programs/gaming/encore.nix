{
  delib,
  inputs,
  pkgs,
  host,
  ...
}:
delib.module {
  name = "programs.gaming.encore";

  options = delib.singleEnableOption (host.vrFeatured && host.gamingFeatured);

  home.ifEnabled = {
    home.packages = [inputs.encore.packages.${pkgs.stdenv.hostPlatform.system}.default];

    xdg.mimeApps = let
      associations = builtins.listToAttrs (
        map
        (name: {
          inherit name;
          value = "com.scoresaber.encore.desktop";
        })
        [
          "x-scheme-handler/encore"
          "x-scheme-handler/beatsaver"
          "x-scheme-handler/web+bsmap"
          "x-scheme-handler/modelsaber"
          "x-scheme-handler/bsplaylist"
          "application/x-beatsaber-playlist"
        ]
      );
    in {
      enable = true;
      associations.added = {
        "application/x-beatsaber-playlist" = "com.scoresaber.encore.desktop";
      };
      defaultApplications = associations;
    };
  };
}
