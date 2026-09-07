{
  delib,
  pkgs,
  ...
}:
delib.host {
  name = "LPC-NE";

  nixos = {myconfig, ...}: {
    environment.systemPackages = with pkgs; [
      nvtopPackages.nvidia
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
        egl-wayland
      ];
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      open = true;
      videoAcceleration = true;

      gsp.enable = true;
      modesetting.enable = true;

      powerManagement.enable = true;
    };
  };
}
