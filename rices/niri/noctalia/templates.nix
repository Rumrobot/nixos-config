{
  delib,
  lib,
  ...
}:
delib.rice {
  name = "niri";

  home = {myconfig, ...}: let
    optionalDesktop = name: lib.optionals myconfig.programs.desktop.${name}.enable [name];
    optionalBrowser = moduleName: templateName: lib.optionals myconfig.programs.browsers.${moduleName}.enable [templateName];
    optionalGaming = name: lib.optionals myconfig.programs.gaming.${name}.enable [name];
    optionalCli = name: lib.optionals myconfig.programs.cli.${name}.enable [name];
    optionalLlm = name: lib.optionals myconfig.programs.llm.${name}.enable [name];
  in {
    programs.noctalia.settings.theme.templates = {
      enable_builtin_templates = true;
      enable_community_templates = true;

      builtin_ids =
        [
          "btop"
          "gtk3"
          "gtk4"
          "qt"
          "hyprland"
          "niri"
          # "starship" # TODO: add starship module
        ]
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
        ++ lib.optionals myconfig.programs.desktop.music-players.enable ["spotifast"]
        ++ optionalGaming "steam"
        ++ optionalCli "neovim"
        ++ optionalLlm "opencode"
        ++ optionalLlm "claude-code"
        ++ optionalLlm "codex";
    };
  };
}
