{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.networking.mqtt-explorer";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled.home.packages = with pkgs; [mqtt-explorer mqttx mqttx-cli];
}
