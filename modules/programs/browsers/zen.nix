{
  delib,
  host,
  inputs,
  ...
}:
delib.module {
  name = "programs.browsers.zen";

  # TODO: Default browser option
  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled = {
    imports = [inputs.zen-browser.homeModules.beta]; # beta / twilight / twilight-official

    programs.zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };

      suppressXdgMigrationWarning = true;
    };
  };
}
