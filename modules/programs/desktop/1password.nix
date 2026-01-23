{
  delib,
  inputs,
  lib,
  homeManagerUser,
  pkgs,
  ...
}: delib.module {
  name = "programs.desktop._1password";

  options = {cfg, ...}: {
    programs.desktop._1password = with delib; {
      enable = boolOption host.guiFeatured;
      gitSigning = boolOption cfg.programs.cli.git.enable;
      sshAgent = boolOption true;
    };
  };

  home.ifEnabled = {myconfig, ...}: let
    shell-plugins = []
      ++ lib.optionals myconfig.programs.cli.gh.enable [ pkgs.gh ];
  in {
    imports = [inputs._1password-shell-plugins.hmModules.default];

    programs._1password-shell-plugins = {
      enable = true;
      plugins = shell-plugins;
    };

    programs.ssh = lib.mkIf cfg.sshAgent {
      enable = true;
      extraConfig = ''
        Host *
            IdentityAgent ${home}
      '';
    };

    programs.git = lib.mkIf cfg.gitSigning {
      extraConfig = {
        gpg = {
          format = "ssh";
          ssh = {
            program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
          };
        };
        commit.gpgsign = cfg.gitSigning;
      };
    };
  };

  nixos.ifEnabled = {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [homeManagerUser];
    };

     # TODO: Make the browsers list from config
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
