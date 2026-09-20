{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.jetbrains.rust-rover";

  options = with delib;
    moduleOptions ({myconfig, ...}: {
      enable = boolOption (host.guiFeatured && host.developmentFeatured && myconfig.programs.development.rust.enable);
    });

  home.ifEnabled.home.packages = [pkgs.jetbrains.rust-rover];
}
