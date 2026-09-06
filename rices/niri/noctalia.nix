{delib, ...}:
delib.rice {
  name = "niri";

  # TODO: Add desktop decorations

  myconfig = {
    gui.noctalia.enable = true;
  };

  home = {
    # Noctalia theming
    programs.noctalia.settings = {
      # General theming
      shell = {
        button_borders = false;
        card_borders = false;
        corner_radius_scale = 0.75;
        input_borders = false;
        popup_borders = false;
        screen_corners.size = 20;
        session.grid_columns = 2;
        shadow.alpha = 0.45;
      };

      # Bar theming
      bar.main = {
        background_opacity = 0.5;
        border = "secondary";
        capsule_thickness = 0.8;
        icon_color = "primary";
        margin_ends = 25;
        padding = 12;
        widget_spacing = 12;
      };

      # UI theming
      shell.panel = {
        transparency_mode = "soft";
        session_position = "center";
        wallpaper_placement = "floating";
        session_placement = "floating";
      };

      # Panel theming
      control_center.width = 730;
      dock = {
        icon_size = 42;
        item_spacing = 2;
        show_dots = true;
        show_instance_count = false;
      };
      lockscreen.blurred_desktop = true;
      notification = {
        border = false;
      };
      osd = {
        border = false;
      };
      theme.templates = {
        enable_builtin_templates = false;
        enable_community_templates = false;
      };

      wallpaper = {
        transition = ["honeycomb"];
        transition_on_startup = true;
      };

      # Widget theming
      widget = {
        audio_visualizer.mirrored = false;
        battery = {
          display_mode = "graphic";
          show_label = false;
        };
        control-center = {
          capsule_fill = "outline";
          capsule_padding = 2;
          glyph = "NixOS";
          scale = 1.35;
        };
        cpu.show_value = false;
        ram.show_value = false;
        workspaces = {
          active_pill_size = 1.9;
          anchor = true;
          capsule_opacity = 0.4;
          pill_scale = 0.8;
        };
      };
    };
    # Stationary wallpaper in overview
    programs.niri.settings = {
      layer-rules = [
        {
          matches = [{namespace = "^noctalia-wallpaper*";}];
          place-within-backdrop = true;
        }
      ];

      layout.background-color = "transparent";

      overview.workspace-shadow.enable = false;
    };
  };
}
