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
    programs.noctalia-shell.enable = true;
    # TODO: fix bar reloading for non-systemd start
    #       or switch to noctalia v5
    programs.noctalia-shell.systemd.enable = true;

    programs.niri.settings = {
      debug.honor-xdg-activation-with-invalid-serial = true;
    };
  };
}
