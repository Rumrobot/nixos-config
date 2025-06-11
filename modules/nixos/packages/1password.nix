{ config, lib, pkgs-unstable, username, ... }:
let
  cfg = config.nixosConfig.packages.onepassword;
in {
  options.nixosConfig.packages.onepassword = {
    enable = lib.mkEnableOption "1Password support" // { default = true; };
    gitSigning = lib.mkEnableOption "Enable git signing via 1Password" // {
      default = true;
    };
    sshAgent = lib.mkEnableOption "Use 1Password as SSH agent" // {
      default = true;
    };
    shell = lib.mkOption {
      type = lib.types.enum [ "bash" "zsh" ];
      default = "bash";
      description = "Shell to load 1Password shell plugins for";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs-unstable; [
      _1password-cli
      _1password-gui
    ];

    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ username ];
    };

  };
}
