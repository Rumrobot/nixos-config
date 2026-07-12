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

  home.ifEnabled =
    { myconfig, ... }:
    let
      llm = myconfig.programs.llm;
      dev = myconfig.programs.development;
      sftpExtension = pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "sftp";
        publisher = "Natizyskunk";
        version = "1.16.3";
        sha256 = "17p8x2pwvh126b3vhrfsx3za98alvb8kf7njjp9wg0hvfa4cy9qy";
      };
    in
    {
      programs.vscode = {
        enable = true;
        profiles.default = {
          enableUpdateCheck = false;

          keybindings = [
            {
              "key" = "alt+shift+f";
              "command" = "editor.action.formatDocument";
              "when" =
                "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
            }
          ];

          extensions =
            with pkgs.vscode-extensions;
            # --- Default ---
            [
              jnoortheen.nix-ide
              ms-vscode.cpptools
              ms-vscode.cmake-tools
              esbenp.prettier-vscode

              github.vscode-pull-request-github
              github.vscode-github-actions
              eamodio.gitlens

              ms-vscode-remote.remote-ssh
              sftpExtension
              ms-vsliveshare.vsliveshare

              wakatime.vscode-wakatime # TODO: WakaTime secret
            ]
            # --- Dev tools ---
            ++ (lib.optionals myconfig.features.docker [
              ms-azuretools.vscode-containers
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
            # --- LLM ---
            ++ (lib.optionals llm.claude-code.enable [
              anthropic.claude-code
            ]);

          userSettings = with lib; {
            "keyboard.dispatch" = "keyCode";
            "editor.defaultFormatter" = "esbenp.prettier-vscode";

            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nil";
            "nix.serverSettings" = {
              "nil" = {
                "formatting" = {
                  "command" = [ "nixfmt" ];
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
          };
        };
      };
    };
}
