{
  delib,
  inputs,
  lib,
  pkgs,
  homeManagerUser,
  ...
}: let
  # https://github.com/noctalia-dev/community-templates/blob/main/vscode/README.md#output-paths
  vscodeThemePath = "/home/${homeManagerUser}/.vscode/extensions/noctalia.noctaliatheme-0.0.5/themes/NoctaliaTheme-color-theme.json";
in
  delib.rice {
    name = "niri";

    home = {myconfig, ...}: let
      hmLib = import "${inputs.home-manager}/modules/lib/stdlib-extended.nix" lib;

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

      # Noctalia merges colors into this file, so it must stay writable
      home.activation.noctaliaFastfetch = hmLib.hm.dag.entryAfter ["writeBoundary"] ''
        if [ ! -e "$XDG_CONFIG_HOME/fastfetch/config.jsonc" ]; then
          run ${pkgs.fastfetch}/bin/fastfetch --gen-config "$XDG_CONFIG_HOME/fastfetch/config.jsonc"
        fi
      '';

      # vscode
      programs.vscode.profiles.default = lib.mkIf myconfig.programs.desktop.vscode.enable {
        extensions = [
          (pkgs.nix-vscode-extensions.vscode-marketplace.noctalia.noctaliatheme.overrideAttrs (old: {
            # Noctalia template writes to this specific path
            postInstall =
              (old.postInstall or "")
              + ''
                ln -sf ${lib.escapeShellArg vscodeThemePath} "$out/$installPrefix/themes/NoctaliaTheme-color-theme.json"
              '';
          }))
        ];
        userSettings."workbench.colorTheme" = "NoctaliaTheme";
      };

      # neovim
      programs.nvf.settings.vim.extraPlugins.noctalia = lib.mkIf myconfig.programs.cli.neovim.enable {
        package = pkgs.vimPlugins.base16-nvim;
        setup = ''
          vim.opt.runtimepath:append(vim.env.XDG_CONFIG_HOME .. '/nvim')
          local ok, matugen = pcall(require, 'matugen')
          if ok then matugen.setup() end
        '';
      };
    };
  }
