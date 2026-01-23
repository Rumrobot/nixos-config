{ delib, host, ... }:
delib.module {
  name = "programs.cli.zoxide";

  options = delib.singleEnableOption host.cliFeatured;

  home.ifEnabled =
  {myconfig, ...}: {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = myconfig.programs.cli.zsh.enabled;
    };
  };
}
