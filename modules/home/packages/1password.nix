{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.nixosConfig.packages._1password;
  onePassPath = "~/.1password/agent.sock";
in {
  options.nixosConfig.packages._1password = {
    enable = lib.mkEnableOption "1Password support" // {default = true;};
    gitSigning =
      lib.mkEnableOption "Enable git signing via 1Password" // {default = true;};
    sshAgent =
      lib.mkEnableOption "Use 1Password as SSH agent" // {default = true;};
    shell = lib.mkOption {
      type = lib.types.enum ["bash" "zsh"];
      default = "bash";
      description = "Shell to load 1Password shell plugins for";
    };
  };

  config = lib.mkIf cfg.enable {
    imports = [inputs._1password-shell-plugins.hmModules.default];
    programs._1password-shell-plugins = {
      enable = true;
      plugins = with pkgs; [gh];
    };
    programs.ssh = {
      enable = true;
      extraConfig = ''
        Host *
            IdentityAgent ${onePassPath}
      '';
    };
    programs.git = {
      enable = true;
      extraConfig = {
        gpg = {
          format = "ssh";
          ssh = {program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";};
        };
        commit.gpgsign = lib.mkDefault true;
      };
    };
    programs.${cfg.shell} = {
      enable = true;
      initExtra = ''
        if [ -f "$HOME/.config/op/plugins.sh" ]; then
          source "$HOME/.config/op/plugins.sh"
        fi
      '';
    };
  };
}
