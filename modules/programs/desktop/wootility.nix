{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.wootility";

  options = delib.singleEnableOption true;

  home.ifEnabled = {
    home.packages = [pkgs.wootility];
  };

  nixos.ifEnabled = {
    environment.systemPackages = [pkgs.wooting-udev-rules];
  };
}
