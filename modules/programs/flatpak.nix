{
  delib,
  inputs,
  pkgs,
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
  };
}
