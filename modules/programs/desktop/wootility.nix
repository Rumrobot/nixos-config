{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.wootility";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = [pkgs.wootility];
  };

  nixos.ifEnabled = {
    services.udev.packages = [pkgs.wooting-udev-rules];
  };
}
