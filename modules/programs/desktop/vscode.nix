{ delib, host, pkgs, ...}:
delib.module {
  name = "programs.desktop.vscode";

  options = delib.singleEnableOption (host.guiFeatured && host.developmentFeatured);

  home.ifEnabled.home.packages = [pkgs.vscode];
}
