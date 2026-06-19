{
  delib,
  host,
  pkgs,
  ...
}: let
  ponytail = pkgs.fetchFromGitHub {
    owner = "DietrichGebert";
    repo = "ponytail";
    rev = "45f7d2f83fb430a65fd512a98ad7b14d79e06636";
    hash = "sha256-BAwav7tf6RuHZ/A7TF/1k1TXWhYAdshlsYB3LbdgUD8=";
  };
in
  delib.module {
    name = "programs.llm.opencode";

    options = delib.singleEnableOption (host.llmFeatured && host.developmentFeatured);

    home.ifEnabled = {
      programs.opencode = {
        enable = true;

        settings = {
          plugin = [
            "opencode-claude-auth"
            "superpowers@git+https://github.com/obra/superpowers.git"
            "${ponytail}/.opencode/plugins/ponytail.mjs"
          ];
        };
      };
    };
  }
