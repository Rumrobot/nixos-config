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
    home.packages = [pkgs.xwayland-satellite];
  };
}
