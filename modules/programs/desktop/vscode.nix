{
  delib,
  lib,
  config,
  host,
  pkgs,
  ...
}: let
  llmLib = import ../../../lib/llm {inherit lib delib;};
in
  delib.module {
    name = "programs.desktop.vscode";

    options = delib.singleEnableOption (host.guiFeatured && host.developmentFeatured);

    myconfig.ifEnabled = {myconfig, ...}: {
      overlays.nix-vscode-extensions.enable = true;
    };

    home.ifEnabled = {myconfig, ...}: let
      llm = myconfig.features.llm;
      llmPrograms = myconfig.programs.llm;
      ollamaEnabled = llmPrograms.ollama.enable;
      dev = myconfig.programs.development;
      latex = myconfig.programs.latex;
      javaJdk = pkgs.zulu25.override {enableJavaFX = true;};
    in {
      programs.vscode = {
        enable = true;
        # Needed for non-GNOME/KDE WM's
        package = pkgs.vscode.override {commandLineArgs = "--password-store=gnome-libsecret";};
        profiles.default = {
          enableUpdateCheck = false;

          keybindings = [
            {
              "key" = "alt+shift+f";
              "command" = "editor.action.formatDocument";
              "when" = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
            }
          ];

          extensions = with pkgs.nix-vscode-extensions.vscode-marketplace;
          # --- Default ---
            [
              jnoortheen.nix-ide
              arrterian.nix-env-selector
              ms-vscode.cpptools
              ms-vscode.cmake-tools
              esbenp.prettier-vscode

              github.vscode-pull-request-github
              github.vscode-github-actions

              ms-vscode-remote.remote-ssh
              natizyskunk.sftp
              ms-vsliveshare.vsliveshare

              wakatime.vscode-wakatime # TODO: WakaTime secret

              editorconfig.editorconfig
              ms-playwright.playwright

              # SP
              mblode.twig-language-2
            ]
            # --- Dev tools ---
            ++ (lib.optionals (myconfig.features.docker.enable || myconfig.features.podman.enable) [
              ms-azuretools.vscode-containers
              ms-vscode-remote.remote-containers
            ])
            # --- Languages ---
            ++ (lib.optionals dev.python.enable [
              ms-python.python
              ms-python.vscode-pylance
              ms-python.debugpy
              charliermarsh.ruff
            ])
            ++ (lib.optionals dev.nodejs.enable [
              svelte.svelte-vscode
              bradlc.vscode-tailwindcss
              dbaeumer.vscode-eslint
            ])
            ++ (lib.optionals dev.android.enable [
              dart-code.dart-code
              dart-code.flutter
            ])
            ++ (lib.optionals dev.java.enable [
              vscjava.vscode-java-pack
              # Extension pack members must be installed explicitly.
              redhat.java
              redhat.vscode-xml
              vscjava.vscode-java-debug
              vscjava.vscode-java-test
              vscjava.vscode-java-dependency
              vscjava.vscode-gradle
            ])
            ++ (lib.optionals dev.rust.enable [
              rust-lang.rust-analyzer
              tamasfe.even-better-toml
            ])
            ++ (lib.optionals latex.enable [
              james-yu.latex-workshop
            ])
            # --- LLM ---
            ++ (lib.optionals llmPrograms.claude-code.enable [
              anthropic.claude-code
            ])
            ++ (lib.optionals llmPrograms.ollama.enable [
              continue.continue
            ]);

          userSettings = with lib;
            {
              "keyboard.dispatch" = "keyCode";
              "editor.defaultFormatter" = "esbenp.prettier-vscode";

              "nix.enableLanguageServer" = true;
              "nix.serverPath" = "nil";
              "nix.serverSettings" = {
                "nil" = {
                  "formatting" = {
                    "command" = ["nixfmt"];
                  };
                };
              };
              "[nix]" = {
                "editor.defaultFormatter" = "jnoortheen.nix-ide";
              };

              "[python]" = mkIf dev.python.enable {
                "editor.defaultFormatter" = "charliermarsh.ruff";
              };

              "claudeCode.claudeProcessWrapper" = mkIf llmPrograms.claude-code.enable "${pkgs.claude-code}/bin/claude";
            }
            // optionalAttrs latex.enable {
              "[latex]" = {
                "editor.defaultFormatter" = "James-Yu.latex-workshop";
              };

              "latex-workshop.formatting.latex" = "tex-fmt";
              "latex-workshop.formatting.tex-fmt.path" = "${pkgs.tex-fmt}/bin/tex-fmt";
              "latex-workshop.latex.recipes" = [
                {
                  name = "tectonic";
                  tools = ["tectonic"];
                }
              ];
              "latex-workshop.latex.tools" = [
                {
                  name = "tectonic";
                  command = "${pkgs.tectonic}/bin/tectonic";
                  args = [
                    "--synctex"
                    "--keep-logs"
                    "--print"
                    "%DOC%.tex"
                  ];
                  env = {};
                }
              ];
              "latex-workshop.latex.clean.method" = "glob";
            }
            // optionalAttrs dev.java.enable {
              "[java]" = {
                "editor.defaultFormatter" = "redhat.java";
              };

              "java.jdt.ls.java.home" = "${javaJdk}";
              "redhat.telemetry.enabled" = false;
            }
            // optionalAttrs ollamaEnabled {
              "github.copilot.chat.byok.ollamaEndpoint" = "http://localhost:${toString config.services.ollama.port}"; # verify name
              "chat.instructionsFilesLocations" = {"~/.copilot/instructions" = true;};
              "chat.useAgentsMdFile" = true;
            };
        };
      };

      home.file.".copilot/instructions/llm.instructions.md" = lib.mkIf llm.enable {
        text = "---\napplyTo: \"**\"\n---\n" + llmLib.renderAgents llm;
      };

      # Autocomplete via Continue
      home.file.".continue/config.yaml" = lib.mkIf (ollamaEnabled && llm.agents.autocompleter != null) {
        text = builtins.toJSON {
          name = "local";
          version = "1.0.0";
          schema = "v1";
          models = lib.mapAttrsToList (_: m: {
            name = m.label;
            provider = "ollama";
            model = m.id;
            roles =
              if m.id == llm.models.${llm.agents.autocompleter}.id
              then ["autocomplete"]
              else [
                "chat"
                "edit"
                "apply"
              ];
          }) (lib.filterAttrs (_: m: m.provider == "ollama") llm.models);
        };
      };
    };
  }
