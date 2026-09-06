{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "gui.noctalia";

  # TODO: Multi compositor support
  options = delib.singleEnableOption false;

  home.always = {
    imports = [
      inputs.noctalia.homeModules.default
    ];
  };

  nixos.ifEnabled = {
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.upower.enable = true;
  };

  home.ifEnabled = {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      settings.shell.launch_apps_as_systemd_services = true;
    };

    programs.niri.settings = {
      debug.honor-xdg-activation-with-invalid-serial = true;
    };
  };
}
