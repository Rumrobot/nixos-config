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
      nmap
      screen
      zip
      unzip
      p7zip
      squashfsTools
      openssl
    ];

    # Zoxide
    programs.zoxide = {
      enable = true;
      "${zoxide-integration}" = true;
    };
  };
}
