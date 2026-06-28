{
  delib,
  config,
  ...
}:
delib.module {
  name = "programs.desktop.coolercontrol";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    programs.coolercontrol.enable = true;

    boot.extraModprobeConfig = ''
      options it87 ignore_resource_conflict=1
    '';
    boot.extraModulePackages = [config.boot.kernelPackages.it87];
    boot.kernelModules = ["it87"];
  };
}
