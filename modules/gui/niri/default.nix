{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "gui.niri";

  options = delib.singleEnableOption false;

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
    home.packages = [pkgs.xwayland-satellite];
  };
}
