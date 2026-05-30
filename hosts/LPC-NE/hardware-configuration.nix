{ delib, config, lib, pkgs, modulesPath, ... }:
delib.host
{
  name = "LPC-NE";

  system = "x86_64-linux";
  home.home.stateVersion = "25.11";
  myconfig.boot.mode = "uefi";

  nixos = {
    system.stateVersion = "25.11";

    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/1bf9392e-f789-4687-a096-7f9dfb409368";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/BDD7-4831";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [
      { device = "/dev/disk/by-uuid/6a910c52-686a-45dc-952d-cc1c0acdbae7"; }
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
