{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.development.packages";

  options = delib.singleEnableOption host.developmentFeatured;

  home.ifEnabled = {
    home.packages = with pkgs; [
      go-task
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
