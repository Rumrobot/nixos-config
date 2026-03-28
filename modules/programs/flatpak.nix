{
  delib,
  inputs,
  pkgs,
  homeconfig,
  ...
}:
delib.module {
  name = "programs.flatpak";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];

    home.packages = [pkgs.flatpak];

    services.flatpak = {
      enable = true;
    };

    home.sessionVariables.XDG_DATA_DIRS = "${builtins.concatStringsSep ":" [
      "/var/lib/flatpak/exports/share"
      "${homeconfig.home.homeDirectory}/.local/share/flatpak/exports/share"
    ]}:$XDG_DATA_DIRS";
  };
}
