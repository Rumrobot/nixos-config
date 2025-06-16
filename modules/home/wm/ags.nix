{
  inputs,
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = config.nixosConfig.windowManagers.ags;
in {
  imports = [inputs.ags.homeManagerModules.default];

  options.nixosConfig.windowManagers.ags.enable =
    lib.mkEnableOption "AGS desktop widgets and bar" // {default = true;};

  config = lib.mkIf cfg.enable {
    programs.ags = {
      enable = true;
      configDir = ./ags;

      # additional packages to add to gjs's runtime
      extraPackages = with pkgs; [
        inputs.ags.packages.${pkgs.system}.battery
        fzf
      ];
    };
  };
}
