{
  delib,
  host,
  inputs,
  lib,
  ...
}:
delib.module {
  name = "programs.desktop.vicinae";

  options = delib.singleEnableOption host.guiFeatured;

  myconfig.ifEnabled = {
    helpers.binds.actions.launcher = delib.mkBindProvider "vicinae" ["vicinae" "toggle"];
  };

  home.ifEnabled = {myconfig, ...}: {
    imports = [
      inputs.vicinae.homeManagerModules.default
    ];

    programs.vicinae = {
      enable = true;
      systemd = {
        enable = true;
        autoStart = true;
        environment = {
          USE_LAYER_SHELL = 1;
        };
      };
    };

    wayland.windowManager.hyprland.settings = lib.mkIf myconfig.gui.hyprland.enable {
      layerrule = [
        "match:class vicinae, blur on"
        "match:class vicinae, ignore_alpha 0"
        # "noanim, vicinae" # Disable fade for vicinae
      ];
    };
  };
}
