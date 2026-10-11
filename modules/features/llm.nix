{
  delib,
  lib,
  ...
}: let
  llm = import ../../lib/llm {inherit lib delib;};
in
  delib.module {
    name = "features.llm";

    options = with delib;
      moduleOptions {
        enable = boolOption false;
        models = attrsOfOption llm.modelType {};
        agents =
          lib.mapAttrs (
            _: desc: allowNull (strOption null) // {description = desc;}
          )
          llm.roles;
      };

    home.ifEnabled = {cfg, ...}: {
      assertions =
        lib.mapAttrsToList (
          role: spec: let
            parts =
              if spec == null
              then []
              else lib.splitString "/" spec;
            modelKey =
              if spec == null
              then null
              else lib.head parts;
            modelExists = spec != null && cfg.models ? ${modelKey};
            r =
              if modelExists
              then llm.resolve cfg.models spec
              else null;
          in {
            assertion =
              spec
              == null
              || (
                modelExists
                && (r.effort == null || r.model.efforts ? ${r.effort})
              );
            message = "programs.llm.agents.${role}: unknown model or effort in '${toString spec}'";
          }
        )
        cfg.agents;

      xdg.configFile."llm/AGENTS.md".text = llm.renderAgents cfg;
    };
  }
