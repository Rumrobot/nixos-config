{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.llm.claude-code";

  options = delib.singleEnableOption (host.llmFeatured && host.developmentFeatured);

  home.ifEnabled.home.packages = [pkgs.claude-code];
}
