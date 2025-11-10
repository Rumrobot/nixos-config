{
  inputs,
  username,
  ...
}: {
  home-manager.users.${username} = {
    imports = [
      inputs.vicinae.homeManagerModules.default
    ];

    services.vicinae = {
      enable = true;

      # window = {
      #   csd = true;
      #   opacity = 0.95;
      #   rounding = 10;
      # };
    };
  };
}
