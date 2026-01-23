{
  delib,
  pkgs,
  ...
}: delib.module {
  name = "programs.cli.git";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    programs.git = {
      enable = true;
      lfs.enable = true;

      # Should be changed to "settings" when nixpkgs is updated
      # and the user and signing parts moved out into programs.git
      extraConfig = {
        user = {
          name = "Rumrobot";
          email = "46647057+Rumrobot@users.noreply.github.com";
        };

        signing = {
          format = "ssh";
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDul1CyPupXyjX+YEoh5y49GxpJr2VLQ1dsn1JB5Qk2c";
          signByDefault = true;
        };

        init.defaultBranch = "main";
      };
    };
  };

  nixos.ifEnabled.environment.systemPackages = [pkgs.git];
}
