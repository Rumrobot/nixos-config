{
  delib,
  host,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.vscode";

  options = with delib; {
    programs.desktop.vscode = {
      enable = boolOption (host.guiFeatured && host.developmentFeatured);
      claude-code = boolOption host.llmFeatured;
    };
  };

  myconfig.ifEnabled = {cfg, ...}: lib.mkIf cfg.claude-code {
    programs.llm.claude-code.enable = true;
  };

  home.ifEnabled = {cfg, ...}: {
    programs.vscode = {
      enable = true;
      profiles.default = {
        extensions = lib.optionals cfg.claude-code (with pkgs.vscode-extensions; [
          anthropic.claude-code
        ]);
        userSettings = lib.mkIf cfg.claude-code {
          "claudeCode.claudeProcessWrapper" = "${pkgs.claude-code}/bin/claude";
        };
      };
    };
  };
}
