{
  delib,
  host,
  ...
}:
delib.module {
  name = "locale";

  options.locale = with delib; {
    enable = boolOption host.isDesktop;

    timeZone = strOption "Europe/Copenhagen";

    locale = strOption "en_US.UTF-8";
    extraLocale = strOption "da_DK.UTF-8";
  };

  nixos.ifEnabled = {cfg, ...}: {
    location.provider = "geoclue2";

    time.timeZone = cfg.timeZone;
    environment.variables.TZ = cfg.timeZone;
    time.hardwareClockInLocalTime = false;
    services.timesyncd.enable = true;

    console.keyMap = "dk";

    services.xserver.xkb = {
      layout = "dk";
    };

    i18n = {
      defaultLocale = cfg.locale;
      extraLocaleSettings = {
        LC_ADDRESS = cfg.locale;
        LC_COLLATE = cfg.locale;
        LC_IDENTIFICATION = cfg.locale;
        LC_NAME = cfg.locale;
        LC_NUMERIC = cfg.locale;
        LC_MEASUREMENT = cfg.extraLocale;
        LC_MONETARY = cfg.extraLocale;
        LC_PAPER = cfg.extraLocale;
        LC_TELEPHONE = cfg.extraLocale;
        LC_TIME = cfg.extraLocale;
      };

      supportedLocales = [
        "${cfg.locale}/UTF-8"
        "${cfg.extraLocale}/UTF-8"
      ];
    };

    networking.timeServers = [
      "time.dfm.dk"
    ];
  };
}
