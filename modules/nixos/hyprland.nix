{
  config,
  username,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  cfg = config.nixosConfig.windowManagers.hyprland;
in {
  options.nixosConfig.windowManagers.hyprland.enable =
    lib.mkEnableOption "Hyprland window manager" // {default = true;};

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;

    # Optional, hint Electron apps to use Wayland:
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    hardware.graphics = {
      enable = true;
      package = pkgs-unstable.mesa;
    };

    # Greeter
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          user = "${username}";
          command = "hyprland";
        };
        default_session = {
          user = "greeter";
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'Hello, ${username}' --asterisks --remember --remember-user-session --time --cmd hyprland";
        };
      };
    };
  };
}
