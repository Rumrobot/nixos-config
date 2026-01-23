{
  delib,
  host,
  lib,
  pkgs,
  ...
}: delib.module {
  name = "hardware.audio";

  options = delib.singleEnableOption host.isDesktop;

  nixos.ifEnabled = {
    security.rtkit.enable = true;
    services.pulseaudio.enable = false;

    environment.systemPackages =
      lib.optionals host.guiFeatured (with pkgs; [
        pavucontrol
      ]);

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
