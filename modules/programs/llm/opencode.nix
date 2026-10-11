{
  delib,
  lib,
  homeconfig,
  host,
  pkgs,
  ...
}: let
  llmLib = import ../../../lib/llm {inherit lib delib;};

  ponytail = pkgs.fetchFromGitHub {
    owner = "DietrichGebert";
    repo = "ponytail";
    rev = "45f7d2f83fb430a65fd512a98ad7b14d79e06636";
    hash = "sha256-BAwav7tf6RuHZ/A7TF/1k1TXWhYAdshlsYB3LbdgUD8=";
  };
in
  delib.module {
    name = "programs.llm.opencode";

    options = with delib;
      moduleOptions ({myconfig, ...}: {
        enable = boolOption (myconfig.features.llm.enable && host.developmentFeatured);
      });

    home.ifEnabled = {myconfig, ...}: let
      llm = myconfig.features.llm;
      ollamaModels = lib.filterAttrs (_: m: m.provider == "ollama") llm.models;
    in {
      programs.opencode = {
        enable = true;

        settings = {
          plugin = [
            "opencode-claude-auth"
            "superpowers@git+https://github.com/obra/superpowers.git"
            "${ponytail}/.opencode/plugins/ponytail.mjs"
          ];

          permission.bash = {
            "git push*" = "deny";
            "gh pr create*" = "ask";
          };

          "$schema" = "https://opencode.ai/config.json";
          instructions = ["${homeconfig.xdg.configHome}/llm/AGENTS.md"];

          provider.ollama = lib.mkIf (ollamaModels != {}) {
            npm = "@ai-sdk/openai-compatible";
            name = "Ollama (local)";
            options.baseURL = "http://localhost:11434/v1";
            models =
              lib.mapAttrs' (
                _: m:
                  lib.nameValuePair m.id {
                    name = m.label;
                    limit = {
                      context = m.context;
                      output = 8192;
                    };
                    variants = lib.mapAttrs (_: e: {reasoningEffort = e.reasoning;}) m.efforts;
                  }
              )
              ollamaModels;
          };

          agent = lib.mapAttrs' (
            role: spec:
              lib.nameValuePair role (
                let
                  r = llmLib.resolve llm.models spec;
                in
                  {
                    description = llmLib.roles.${role};
                    mode = "subagent";
                    model = r.ref;
                  }
                  // lib.optionalAttrs (r.effort != null) {
                    reasoningEffort = r.model.efforts.${r.effort}.reasoning;
                  }
              )
          ) (lib.filterAttrs (role: spec: spec != null && role != "autocompleter") llm.agents);
        };
      };
    };
  }
