{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.llm.claude-code";

  options = delib.singleEnableOption (host.llmFeatured && host.developmentFeatured);

  home.ifEnabled = {
    programs.claude-code = {
      enable = true;

      plugins = [
        (pkgs.fetchFromGitHub {
          owner = "obra";
          repo = "superpowers";
          rev = "6fd4507659784c351abbd2bc264c7162cfd386dc";
          hash = "sha256-P/FD8HTQO+QzvMe3A/B2v2vjs8T6ZmIYH3MPp79dSzo=";
        })

        (pkgs.fetchFromGitHub {
          owner = "DietrichGebert";
          repo = "ponytail";
          rev = "45f7d2f83fb430a65fd512a98ad7b14d79e06636";
          hash = "sha256-BAwav7tf6RuHZ/A7TF/1k1TXWhYAdshlsYB3LbdgUD8=";
        })

        "${pkgs.fetchFromGitHub {
          owner = "anthropics";
          repo = "claude-code";
          rev = "feabcc3c2b9abf057a3721cf5427f8f50d75618f";
          hash = "sha256-8m9s/OpebAkl50/fM6VynPKjVejHSnDYmrPyivwEL3U=";
        }}/plugins/code-review"
      ];
    };
  };
}
