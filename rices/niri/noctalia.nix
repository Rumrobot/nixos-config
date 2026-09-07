{
  delib,
  lib,
  ...
}:
delib.rice {
  name = "niri";

  # TODO: Add desktop decorations

  myconfig = {
    gui.noctalia.enable = true;
  };

  home = {myconfig, ...}: let
    optionalGui = name: lib.optionals myconfig.gui.${name}.enable [name];
    optionalDesktop = name: lib.optionals myconfig.programs.desktop.${name}.enable [name];
    optionalBrowser = moduleName: templateName: lib.optionals myconfig.programs.browsers.${moduleName}.enable [templateName];
    optionalGaming = name: lib.optionals myconfig.programs.gaming.${name}.enable [name];
    optionalCli = name: lib.optionals myconfig.programs.cli.${name}.enable [name];
    optionalLlm = name: lib.optionals myconfig.programs.llm.${name}.enable [name];
  in {
    programs.ghostty.settings = lib.mkIf myconfig.programs.desktop.ghostty.enable {
      background-opacity = 0.75;
      theme = "noctalia";
    };
    programs.vesktop.vencord.settings.enabledThemes =
      lib.mkIf myconfig.programs.desktop.discord.enable ["noctalia.theme.css"];

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
        background_opacity = 0.6;
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
        border = true;
        background_opacity = 0.6;
      };
      osd = {
        border = true;
        background_opacity = 0.6;
      };
      theme = {
        source = "wallpaper";
        wallpaper_scheme = "m3-tonal-spot";

        templates = {
          enable_builtin_templates = true;
          enable_community_templates = true;

          builtin_ids =
            [
              "btop"
              "gtk3"
              "gtk4"
              "qt"
              # "starship" # TODO: add starship module
            ]
            ++ optionalGui "hyprland"
            ++ optionalGui "niri"
            ++ optionalDesktop "ghostty";
          community_ids =
            [
              "fastfetch"
              "hyprtoolkit"
              "tmux"
              "blender"
              # "darktable"
              # "prismlauncher"
            ]
            ++ optionalBrowser "zen" "zen-browser"
            ++ optionalBrowser "chromium" "ungoogled-chromium"
            ++ optionalDesktop "vicinae"
            ++ optionalDesktop "discord"
            ++ optionalDesktop "obsidian"
            ++ optionalDesktop "vscode"
            ++ optionalDesktop "gimp"
            ++ optionalGaming "steam"
            ++ optionalCli "neovim"
            ++ optionalLlm "opencode"
            ++ optionalLlm "claude-code"
            ++ optionalLlm "codex";
        };
      };

      wallpaper = {
        transition = ["honeycomb"];
        transition_on_startup = true;
      };

      # Widget theming
      widget = {
        audio_visualizer = {
          bands = 32;
          centered = false;
          mirrored = false;
          color_2 = "error";
          show_when_idle = true;
          width = 100;
        };
        media.art_size = 24;
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
        cpu = {
          show_value = false;
          visualization = "gauge";
        };
        ram = {
          show_value = false;
          visualization = "gauge";
        };
        spacer-large.length = 20;
        workspaces = {
          active_pill_size = 1.9;
          anchor = true;
          capsule_opacity = 0.4;
          font_weight = 500;
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
        {
          matches = [
            {namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";}
          ];
          background-effect.xray = false;
        }
        {
          matches = [{namespace = "noctalia-window-switcher";}];
          background-effect = {
            blur = true;
            xray = false;
          };
        }
      ];

      layout.background-color = "transparent";

      overview.workspace-shadow.enable = false;
    };
  };
}
