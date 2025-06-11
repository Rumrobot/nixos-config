{
  nixosConfig,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = nixosConfig.packages.onepassword;
  onePassPath = "~/.1password/agent.sock";
in {
  config = lib.mkIf cfg.enable {
    imports = [inputs._1password-shell-plugins.hmModules.default];
    programs._1password-shell-plugins = {
      enable = true;
      plugins = with pkgs; [gh];
    };

    programs.ssh = lib.mkIf cfg.sshAgent {
      enable = true;
      extraConfig = ''
        Host *
            IdentityAgent ${onePassPath}
      '';
    };

    programs.git = lib.mkIf cfg.gitSigning {
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
