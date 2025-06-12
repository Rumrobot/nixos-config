{
  config,
  lib,
  ...
}: let
  cfg = config.nixosConfig.system.audio;
in {
  options.nixosConfig.system.audio.enable =
    lib.mkEnableOption "Audio configuration" // {default = true;};

  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
