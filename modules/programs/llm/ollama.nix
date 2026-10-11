{
  delib,
  lib,
  config,
  pkgs,
  ...
}: let
  ollamaModels = {
    qwen3-30b = {
      base = "qwen3:30b";
      label = "Qwen3 30B (plan)";
      context = 49152;
      parameters = {
        temperature = 0.6;
        top_p = 0.95;
        top_k = 20;
      };
      efforts = {
        low = {
          reasoning = "none";
          description = "thinking off, fast";
        };
        high = {
          reasoning = "high";
          description = "thinking on, for hard problems";
        };
      };
    };
    qwen3-coder-30b = {
      base = "qwen3-coder:30b";
      label = "Qwen3 Coder 30B (coding)";
      context = 65536;
      parameters = {
        temperature = 0.7;
        top_p = 0.8;
        top_k = 20;
      };
    };
    qwen25-coder-1_5b = {
      base = "qwen2.5-coder:1.5b-base";
      label = "Qwen2.5 Coder 1.5B (autocomplete)";
      context = 4096;
    };
    gemma4-12b = {
      base = "gemma4:12b";
      label = "Gemma 4 12B (ui)";
      context = 16384;
    };
  };
in
  delib.module {
    name = "programs.llm.ollama";

    options = delib.singleEnableOption false;

    myconfig.ifEnabled = {myconfig, ...}: {
      features.llm = {
        enable = true;

        models =
          lib.mapAttrs' (
            key: m:
              lib.nameValuePair "ollama-${key}" (
                (lib.removeAttrs m ["base" "parameters"])
                // {
                  id = key;
                  provider = "ollama";
                  invoke = ''
                    Select `${key}` (${m.label}) under the `ollama` provider in your harness's model picker, or pass `ollama/${key}` wherever a model is specified.
                    If it isn't listed, check `ollama list`; if absent, run `systemctl restart ollama-derived-models`.
                  '';
                }
              )
          )
          ollamaModels;

        agents = {
          autocompleter = lib.mkDefault "ollama-qwen25-coder-1_5b";
          plannerLight = lib.mkDefault "ollama-qwen3-30b/low";
          planner = lib.mkDefault "ollama-qwen3-30b/high";
          researcher = lib.mkDefault "ollama-qwen3-30b/low";
          programPlanner = lib.mkDefault "ollama-qwen3-30b/high";
          programmer = lib.mkDefault "ollama-qwen3-coder-30b";
          uiDesigner = lib.mkDefault "ollama-gemma4-12b";
          summarizer = lib.mkDefault "ollama-qwen3-30b/low";
        };
      };
    };

    nixos.ifEnabled = let
      modelfile = m:
        pkgs.writeText "Modelfile" ''
          FROM ${m.base}
          PARAMETER num_ctx ${toString m.context}
          ${lib.concatStringsSep "\n" (
            lib.mapAttrsToList (k: v: "PARAMETER ${k} ${toString v}") (m.parameters or {})
          )}
        '';
      ollama = lib.getExe config.services.ollama.package;
    in {
      services.ollama = {
        enable = true;
        package = with pkgs;
          if config.hardware.nvidia.enabled
          then ollama-cuda
          else ollama;

        loadModels = lib.unique (lib.mapAttrsToList (_: m: m.base) ollamaModels);

        # Prune any local models that are NOT listed above
        # syncModels = true;

        environmentVariables = {
          OLLAMA_CONTEXT_LENGTH = "16384"; # fallback for anything not using a derived model
          OLLAMA_FLASH_ATTENTION = "1";
          OLLAMA_KV_CACHE_TYPE = "q8_0";
          OLLAMA_MAX_LOADED_MODELS = "2";
          OLLAMA_NUM_PARALLEL = "1";
        };
      };

      systemd.services.ollama-derived-models = {
        description = "Create context-tuned Ollama models";
        wantedBy = ["multi-user.target"];
        after = ["ollama.service" "ollama-model-loader.service"];
        bindsTo = ["ollama.service"];
        wants = ["ollama-model-loader.service"];
        environment = config.systemd.services.ollama.environment;
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          set -eu
          ${lib.concatStringsSep "\n" (lib.mapAttrsToList (key: m: "${ollama} create ${key} -f ${modelfile m}") ollamaModels)}
        '';
      };
    };
  }
