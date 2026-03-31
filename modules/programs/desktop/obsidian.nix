{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.desktop.obsidian";

  options = delib.singleEnableOption host.guiFeatured;

  # TODO: LiveSync setup
  home.ifEnabled = {
    programs.obsidian = {
      enable = true;
    };
  };
}
