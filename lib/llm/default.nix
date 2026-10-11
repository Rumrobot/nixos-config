{
  lib,
  delib,
}: rec {
  roles = {
    autocompleter = "Inline code completion";
    plannerLight = "Planning for small or low-risk tasks";
    planner = "Planning for complex or high-risk tasks";
    researcher = "Reading docs/code and gathering information";
    programPlanner = "Turning a plan into file-level implementation steps";
    programmer = "Writing and editing code";
    uiDesigner = "UI/UX and frontend layout work";
    summarizer = "Condensing logs, diffs, and long text";
  };

  effortType = lib.types.submodule {
    options = {
      reasoning = delib.enumOption ["none" "low" "medium" "high"] "none";
      description = delib.strOption "";
    };
  };

  modelType = lib.types.submodule {
    options = {
      provider = delib.noDefault (delib.strOption null);
      id = delib.noDefault (delib.strOption null);
      label = delib.noDefault (delib.strOption null);
      context = delib.intOption 32768;
      efforts = delib.attrsOfOption effortType {};
      invoke = delib.strOption "";
    };
  };

  # "model-key" or "model-key/effort" -> { model, effort, ref }
  resolve = models: spec: let
    parts = lib.splitString "/" spec;
    model = models.${lib.head parts};
  in {
    inherit model;
    effort =
      if lib.length parts > 1
      then lib.elemAt parts 1
      else null;
    ref = "${model.provider}/${model.id}";
  };

  describeModel = m:
    "**${m.label}** (`${m.id}`, ${m.provider}, ${toString m.context} ctx)"
    + lib.optionalString (m.efforts != {}) (
      " Efforts: "
      + lib.concatStringsSep ", " (lib.mapAttrsToList (n: e: "`${n}` (${e.description})") m.efforts)
      + "."
    )
    + lib.optionalString (m.invoke != "")
    " ${lib.replaceStrings ["{effort}"] ["<effort>"] m.invoke}";

  describeRole = models: spec:
    if spec == null
    then "_not configured, do this yourself_"
    else let
      parts = lib.splitString "/" spec;
      modelKey = lib.head parts;
      modelExists = models ? ${modelKey};
      r =
        if modelExists
        then resolve models spec
        else null;
      effortExists = modelExists && (r.effort == null || r.model.efforts ? ${r.effort});
    in
      if !modelExists
      then "_invalid model `${modelKey}`_"
      else if !effortExists
      then "_invalid effort `${r.effort}` for model `${modelKey}`_"
      else
        "**${r.model.label}**"
        + lib.optionalString (r.effort != null)
        ", effort `${r.effort}` (${r.model.efforts.${r.effort}.description})"
        + ". "
        + lib.replaceStrings ["{effort}"] [(toString r.effort)] r.model.invoke;

  render = {
    models,
    agents,
    template,
  }: let
    placeholders =
      lib.mapAttrs' (r: s: lib.nameValuePair "agent_${r}" (describeRole models s)) agents
      // {
        roster = lib.concatMapStringsSep "\n" (m: "- ${describeModel m}") (lib.attrValues models);
      };
  in
    lib.replaceStrings (map (k: "{{${k}}}") (
      lib.attrNames placeholders
    )) (lib.attrValues placeholders)
    template;

  renderAgents = cfg:
    render {
      inherit (cfg) models agents;
      template = builtins.readFile ./instructions/AGENTS.md;
    };
}
