{ lib, pkgs, inputs, ... }:
let
  onePassPath = "~/.1password/agent.sock";
in {
  # Install shell-plugins
  imports = [ inputs._1password-shell-plugins.hmModules.default ];
  programs._1password-shell-plugins = {
    enable = true;
    plugins = with pkgs; [ gh ];
  };

  # SSH management (remember to enable inside 1Password)
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ${onePassPath}
    '';
  };

  # Git configuration (remember to enable inside 1Password)
  programs.git = {
    enable = true;
    extraConfig = {
      gpg = {
        format = "ssh";
        ssh = {
          program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
        };
      };
      commit.gpgsign = lib.mkDefault true;
    };
  };

  # GitHub CLI authentication
  programs.bash = {
    enable = true;
    initExtra = ''
      if [ -f "$HOME/.config/op/plugins.sh" ]; then
        source "$HOME/.config/op/plugins.sh"
      fi
    '';
  };
}
