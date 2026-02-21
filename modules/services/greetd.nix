{
  delib,
  host,
  pkgs,
  homeManagerUser,
  ...
}:
delib.module {
  name = "service.greetd";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled = {
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          user = "${homeManagerUser}";
          command = "hyprland"; # TODO: Config variable
        };

        default_session = {
          user = "greeter";
          command = "${pkgs.tuigreet}/bin/tuigreet --greeting 'Hello, ${homeManagerUser}' --asterisks --remember --remember-user-session --time --cmd start-hyprland"; # TODO: Config variable
        };
      };
    };
  };
}
