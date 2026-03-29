{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "gui.hyprpanel";

  # TODO: Multi compositor support
  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      hyprpicker
      wf-recorder
      brightnessctl
      grimblast
      btop
      matugen
      nerd-fonts.mononoki
    ];

    programs.hyprpanel = {
      enable = true;
      systemd.enable = false;
    };

    wayland.windowManager.hyprland.settings = {
      exec-once = [
        "hyprpanel"
      ];
    };
  };
}
