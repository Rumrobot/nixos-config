{
  config,
  lib,
  pkgs-unstable,
  username,
  ...
}: let
  cfg = config.nixosConfig.packages._1password;
in {
  options.nixosConfig.packages._1password = {
    enable = lib.mkEnableOption "1Password support" // {default = true;};
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs-unstable; [
      _1password-cli
      _1password-gui
    ];
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [username];
    };

    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          zen
        '';
        mode = "0755";
      };
    };
  };
}
