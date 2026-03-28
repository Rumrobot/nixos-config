{
  delib,
  host,
  ...
}:
delib.module {
  name = "programs.llm.opencode";

  options = delib.singleEnableOption (host.llmFeatured && host.developmentFeatured);

  home.ifEnabled = {
    programs.opencode = {
      enable = true;

      settings = {
        plugin = ["opencode-claude-auth"];
      };
    };
  };
}
