{
  inputs,
  config,
  osConfig,
  pkgs,
  system,
  ...
}: let
  cfg = config;
in {
  imports = [../../modules/home];

  # Import nixos custom config
  config.nixosConfig = osConfig.nixosConfig;

  # Git config
  programs.git = {
    enable = true;
    userName = "Rumrobot";
    userEmail = "46647057+Rumrobot@users.noreply.github.com";
    signing = {
      format = "ssh";
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDul1CyPupXyjX+YEoh5y49GxpJr2VLQ1dsn1JB5Qk2c";
    };

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
