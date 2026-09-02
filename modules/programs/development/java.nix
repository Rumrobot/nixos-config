{
  delib,
  pkgs,
  ...
}: let
  # openjdk or zulu
  jdkWithFX = pkgs.zulu25.override {
    enableJavaFX = true; # for JavaFX
    # include following line if JavaFX with Webkit is needed
    # openjfx_jdk = pkgs.openjfx.override { withWebKit = true; };
  };
in
  delib.module {
    name = "programs.development.java";

    options = delib.singleEnableOption false;

    nixos.ifEnabled = {
      programs.java = {
        enable = true;
        package = jdkWithFX;
      };
    };
  }
