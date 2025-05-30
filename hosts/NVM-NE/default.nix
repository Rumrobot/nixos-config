{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/system.nix
    ../../modules/gnome.nix

    ./hardware-configuration.nix
  ];
  # NixOS system
  system.stateVersion = "25.05";
  
  # Bootloader 
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # Networking
  networking.hostName = "NVM-NE";
  networking.networkmanager.enable = true;

  # Timezone
  time.timeZone = "Europe/Copenhagen";

  # Keyboard configuration
  console.keyMap = "dk-latin1";

  services.xserver.xkb = {
    layout = "dk";
    variant = "winkeys";
  };

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Location fetching
  services.geoclue2.enable = true;

  # Enable copy/paste in KVM
  services.spice-vdagentd.enable = true;
  systemd.user.services.spice-vdagent-client = {
    description = "spice-vdagent client";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
      Restart = "on-failure";
      RestartSec = "5";
    };
  };
  systemd.user.services.spice-vdagent-client.enable = true;
}
