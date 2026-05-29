{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.desktop.discord";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled = {
    programs.vesktop = {
      enable = true;

      vencord.settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        notifyAboutUpdates = true;

        plugins = {
          ClearURLs.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          FakeNitro.enabled = true;
          CallTimer.enabled = true;
          CopyFileContents.enabled = true;
          SendTimestamps.enabled = true;
          YoutubeAdblock.enabled = true;
        };
      };
    };
  };
}
