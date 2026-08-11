{
  delib,
  host,
  lib,
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
  settings = {
    approvals_reviewer = "auto_review";

    features.plugins = true;

    plugins = {
      "ponytail@home-manager".enabled = true;
      "superpowers@home-manager".enabled = true;
    };
  };
in
  delib.module {
    name = "programs.llm.codex";

    options = delib.singleEnableOption (host.llmFeatured && host.developmentFeatured);

    home.ifEnabled = {
      programs.codex = {
        enable = true;

        plugins = [
          superpowers
          ponytail
        ];
      };

      home.file.".codex/config.toml".enable = lib.mkForce false;
    };

    nixos.ifEnabled = {
      # https://github.com/nix-community/home-manager/issues/9397
      # https://github.com/openai/codex/issues/14601
      environment.etc."codex/config.toml".source =
        (pkgs.formats.toml {}).generate "codex-config.toml" settings;
    };
  }
