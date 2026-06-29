{
  delib,
  host,
  pkgs,
  ...
}: let
  superpowers = pkgs.fetchFromGitHub {
    name = "superpowers";
    owner = "obra";
    repo = "superpowers";
    rev = "6fd4507659784c351abbd2bc264c7162cfd386dc";
    hash = "sha256-P/FD8HTQO+QzvMe3A/B2v2vjs8T6ZmIYH3MPp79dSzo=";
  };
  ponytail = pkgs.fetchFromGitHub {
    name = "ponytail";
    owner = "DietrichGebert";
    repo = "ponytail";
    rev = "45f7d2f83fb430a65fd512a98ad7b14d79e06636";
    hash = "sha256-BAwav7tf6RuHZ/A7TF/1k1TXWhYAdshlsYB3LbdgUD8=";
  };
in
  delib.module {
    name = "programs.llm.codex";

    options = delib.singleEnableOption (host.llmFeatured && host.developmentFeatured);

    home.ifEnabled = {
      programs.codex = {
        enable = true;

        plugins = [superpowers ponytail];

        settings.approvals_reviewer = "auto_review";
      };
    };
  }
