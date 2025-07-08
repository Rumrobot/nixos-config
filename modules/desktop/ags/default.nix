{
  inputs,
  lib,
  config,
  pkgs-unstable,
  username,
  system,
  ...
}: with lib; let 
  cfg = config.ne.desktop.ags;
  
  astalRuntimePkgs = with inputs.ags.packages.${system}; [
    hyprland
    battery
  ];
  # ++ pkgsExtra;
  
  # pkgsExtra = with pkgs-unstable; [];

  # pkgsExtraAgs = with pkgs-unstable; [];
in {
  options.ne.desktop.ags = {
    enable = mkEnableOption "AGS bar and UI";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      imports = [inputs.ags.homeManagerModules.default];

      programs.ags = {
        enable = true;
        configDir = ./.;
        extraPackages = astalRuntimePkgs; # ++ pkgsExtraAgs;
      };

      home.packages = astalRuntimePkgs;
    };
  }; 
}
