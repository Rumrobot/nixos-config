{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.desktop.vscode";

  options = delib.singleEnableOption (host.guiFeatured && host.developmentFeatured);

  home.ifEnabled = {
    programs.vscode = {
      enable = true;
    };
  };
}
