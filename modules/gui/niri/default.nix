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
    security.polkit.enable = true;

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    systemd.user.services.niri-flake-polkit.enable = false;
  };

  home.ifEnabled = {
    services.hyprpolkitagent.enable = true;

    home.packages = [pkgs.xwayland-satellite];
  };
}
