{
  delib,
  homeconfig,
  host,
  pkgs,
  lib,
  homeManagerUser,
  ...
}: let
  sdkRoot = "${homeconfig.home.homeDirectory}/.local/share/android/sdk";
  fvmCache = "${homeconfig.home.homeDirectory}/.local/share/fvm";
in
  delib.module {
    name = "programs.development.android";

    options = delib.singleEnableOption host.developmentFeatured;

    myconfig.ifEnabled.programs.development.java.enable = true;

    nixos.ifEnabled.users.users.${homeManagerUser}.extraGroups = ["kvm"];

    home.ifEnabled = {
      home.packages = with pkgs;
        [
          fvm
          android-tools
        ]
        ++ lib.optional host.guiFeatured android-studio;

      home.shellAliases = {
        flutter = "fvm flutter";
        dart = "fvm dart";
      };

      home.sessionPath = ["${fvmCache}/default/bin"];

      home.sessionVariables = {
        ANDROID_HOME = sdkRoot;
        ANDROID_SDK_ROOT = sdkRoot;
        FLUTTER_SUPPRESS_ANALYTICS = "true"; # dart needs `dart --disable-analytics` once
        FVM_CACHE_PATH = fvmCache;
      };
    };
  }
