{
  pkgs,
  username,
  ...
}: {
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
}
