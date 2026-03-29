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
    # TODO: Enable power-profiles-daemon or tuned (conflicts with tlp)
  };

  home.ifEnabled = {
    programs.noctalia-shell.enable = true;

    programs.niri.settings = {
      spawn-at-startup = [
        {argv = ["noctalia-shell"];}
      ];

      debug.honor-xdg-activation-with-invalid-serial = true;
    };
  };
}
