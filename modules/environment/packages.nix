{
  pkgs,
  username,
  config,
  ...
}: let
  zoxide-integration = "enable${config.nixosConfig.environment.shell.name}Integration";
in {
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      zoxide
    ];

    # Zoxide
    programs.zoxide = {
      enable = true;
      "${zoxide-integration}" = true;
    };
  };
}
