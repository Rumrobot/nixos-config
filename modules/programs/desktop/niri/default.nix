{
  delib,
  host,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.niri";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.always = {
    imports = [
      inputs.niri-flake.nixosModules.niri
    ];
  };

  nixos.ifEnabled = {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };
  };

  home.ifEnabled = {
    home.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
