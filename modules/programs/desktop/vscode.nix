{
  delib,
  host,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.vscode";

  options = delib.singleEnableOption (host.guiFeatured && host.developmentFeatured);

  home.ifEnabled = {myconfig, ...}: let
    llm = myconfig.programs.llm;
    dev = myconfig.programs.development;
    javaJdk = pkgs.zulu25.override {enableJavaFX = true;};
    javaDebuggerExtension = pkgs.vscode-utils.extensionFromVscodeMarketplace {
      name = "vscode-java-debug";
      publisher = "vscjava";
      version = "0.58.1";
      sha256 = "sha256-S+kNAaYBjVxAuYlMbpQUM9DyTW76yRvokTzl+32pUgc=";
    };
    sftpExtension = pkgs.vscode-utils.extensionFromVscodeMarketplace {
      name = "sftp";
      publisher = "Natizyskunk";
      version = "1.16.3";
      sha256 = "17p8x2pwvh126b3vhrfsx3za98alvb8kf7njjp9wg0hvfa4cy9qy";
    };
    playwrightExtension = pkgs.vscode-utils.extensionFromVscodeMarketplace {
      name = "playwright";
      publisher = "ms-playwright";
      version = "1.1.19";
      sha256 = "1xppas4qla2bsppb89ks4mnrby2g3gra4irabnimkcmaz4m3wr9p";
    };
    twigExtension = pkgs.vscode-utils.extensionFromVscodeMarketplace {
      name = "twig-language-2";
      publisher = "mblode";
      version = "0.10.0";
      sha256 = "1ndaspy9391pnxxi0cgwamr9j41h3qyinp83n8wrm1r686xcqp8b";
    };
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

        extensions = with pkgs.vscode-extensions;
        # --- Default ---
          [
            jnoortheen.nix-ide
            ms-vscode.cpptools
            ms-vscode.cmake-tools
            esbenp.prettier-vscode

            github.vscode-pull-request-github
            github.vscode-github-actions

            ms-vscode-remote.remote-ssh
            sftpExtension
            ms-vsliveshare.vsliveshare

            wakatime.vscode-wakatime # TODO: WakaTime secret

            editorconfig.editorconfig
            playwrightExtension

            # SP
            twigExtension
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
            javaDebuggerExtension
            vscjava.vscode-java-test
            vscjava.vscode-java-dependency
            vscjava.vscode-gradle
          ])
          # --- LLM ---
          ++ (lib.optionals llm.claude-code.enable [
            anthropic.claude-code
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

            "claudeCode.claudeProcessWrapper" = mkIf llm.claude-code.enable "${pkgs.claude-code}/bin/claude";
          }
          // optionalAttrs dev.java.enable {
            "[java]" = {
              "editor.defaultFormatter" = "redhat.java";
            };

            "java.jdt.ls.java.home" = "${javaJdk}";
            "redhat.telemetry.enabled" = false;
          };
      };
    };
  };
}
