{
  config,
  lib,
  username,
  ...
}: let
  hasNixos = config ? environment;
  hasHome = config ? home;
in {
  options.nixosConfig.core.enable =
    lib.mkEnableOption "Core system settings" // {default = true;};

  config = lib.mkMerge [
    (lib.mkIf hasNixos {
      i18n.defaultLocale = "en_DK.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "da_DK.UTF-8";
        LC_IDENTIFICATION = "da_DK.UTF-8";
        LC_MEASUREMENT = "da_DK.UTF-8";
        LC_MONETARY = "da_DK.UTF-8";
        LC_NAME = "da_DK.UTF-8";
        LC_NUMERIC = "da_DK.UTF-8";
        LC_PAPER = "da_DK.UTF-8";
        LC_TELEPHONE = "da_DK.UTF-8";
        LC_TIME = "da_DK.UTF-8";
      };

      services.geoclue2.enable = true;
      services.printing.enable = true;
    })

    (lib.mkIf hasHome {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
        stateVersion = "25.05";
      };
      programs.home-manager.enable = true;
    })
  ];
}
