{
  delib,
  host,
  pkgs,
  lib,
  homeManagerUser,
  ...
}: let
  android =
    (import pkgs.path {
      inherit (pkgs.stdenv.hostPlatform) system;
      config = {
        allowUnfree = true;
        android_sdk.accept_license = true;
      };
    }).androidenv.composeAndroidPackages {
      includeNDK = true;
      includeEmulator = true;
      includeSystemImages = true;
      systemImageTypes = ["google_apis_playstore"];
      abiVersions = ["x86_64"];
    };

  sdkRoot = "${android.androidsdk}/libexec/android-sdk";
in
  delib.module {
    name = "programs.development.android";

    options = delib.singleEnableOption host.developmentFeatured;

    nixos.ifEnabled.users.users.${homeManagerUser}.extraGroups = ["kvm"];

    home.ifEnabled = {
      home.packages = with pkgs;
        [flutter jdk21 android.androidsdk android-tools]
        ++ lib.optional host.guiFeatured (android-studio.withSdk android.androidsdk);

      home.sessionVariables = {
        ANDROID_HOME = sdkRoot;
        ANDROID_SDK_ROOT = sdkRoot;
        JAVA_HOME = "${pkgs.jdk21}";
        FLUTTER_SUPPRESS_ANALYTICS = "true"; # dart needs `dart --disable-analytics` once
      };
    };
  }
