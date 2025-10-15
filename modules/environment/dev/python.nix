{
  lib,
  config,
  pkgs-unstable,
  ...
}:
with lib; let
  cfg = config.nixosConfig.environment.dev.python;
in {
  options.nixosConfig.environment.dev.python = {
    enable = mkEnableOption "Python";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs-unstable; [
      python3
      python3Packages.pip
      python3Packages.venv
    ];
  };
}
