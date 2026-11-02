{
  delib,
  pkgs,
  homeconfig,
  lib,
  inputs,
  ...
}: let
  dataHome = homeconfig.xdg.dataHome;
  journalDir = "${dataHome}/Steam/steamapps/compatdata/359320/pfx/drive_c/users/steamuser/Saved Games/Frontier Developments/Elite Dangerous";
  hmLib = import "${inputs.home-manager}/modules/lib/stdlib-extended.nix" lib;

  edmarketconnector = pkgs.edmarketconnector.overrideAttrs (old: {
    postFixup =
      (old.postFixup or "")
      + ''
        wrapProgram $out/bin/edmarketconnector \
          --prefix PYTHONPATH : ${pkgs.python3Packages.makePythonPath [pkgs.python3Packages.sqlalchemy]}
      '';
  });
in
  delib.module {
    name = "programs.gaming.elitedangerous";

    options = with delib;
      moduleOptions (
        {myconfig, ...}: {
          enable = boolOption false;
          steam.enable = boolOption myconfig.programs.gaming.steam.enable;
        }
      );

    home.ifEnabled = {cfg, ...}: {
      home.packages = with pkgs; [
        min-ed-launcher
        edmarketconnector
      ];

      # Needs Steam launch options: PROTON_ENABLE_WAYLAND=1 WAYLANDDRV_PRIMARY_MONITOR=DP-2 MinEdLauncher %command% /autorun /autoquit waitForExit
      xdg.configFile."min-ed-launcher/settings.json".text = builtins.toJSON (
        {
          watchForCrashes = false;
          processes = [
            {
              fileName = "${edmarketconnector}/bin/edmarketconnector";
              alias = "ED Market Connector";
              arguments = ["--start_min"];
            }
          ];
        }
        // lib.optionalAttrs cfg.steam.enable {
          gameLocation = "${dataHome}/Steam/steamapps/common/Elite Dangerous";
        }
      );

      # EDMC plugins
      xdg.dataFile = {
        "EDMarketConnector/plugins/EDMC-Pioneer".source = pkgs.fetchzip {
          url = "https://github.com/Silarn/EDMC-Pioneer/releases/download/v2.4.2/EDMC-Pioneer-2.4.2.zip";
          hash = "sha256-YQ3FA70II6FAFvJ9GRwrU7SGpml4Z0GO3WWqw1tzgn4=";
        };
        "EDMarketConnector/plugins/ExploData".source = pkgs.fetchzip {
          url = "https://github.com/Silarn/EDMC-Pioneer/releases/download/v2.4.2/ExploData-1.5.1-db-12.native.python.zip";
          hash = "sha256-czdkBn1BjRE4qUTO1Bg6v6KGEXe1yvuEwtgl4m6dOTM=";
        };
        "EDMarketConnector/plugins/EDMC-BioScan".source = pkgs.fetchzip {
          url = "https://github.com/Silarn/EDMC-BioScan/releases/download/v2.12.2/EDMC-BioScan-2.12.2.zip";
          hash = "sha256-hdRnrnxzL4ec12Kyh41MBrQd4QwRfcKtS7fWF8HvvB0=";
        };
      };

      home.activation.edmcSettings = hmLib.hm.dag.entryAfter ["linkGeneration"] (
        hmLib.hm.generators.mkImpureConfigMerger {
          inherit pkgs;
          format = "toml";
          empty = "{}";
          jqOperation = "$dynamic * $static";
          path = "${dataHome}/EDMarketConnector/config.toml";
          mode = "600";
          staticSettings = (pkgs.formats.toml {}).generate "edmc-settings" {
            settings =
              {
                journaldir = journalDir;
                plugin_dir = "${dataHome}/EDMarketConnector/plugins";

                station_provider = "Inara";
                shipyard_provider = "EDSY";
                system_provider = "Inara";

                edsm_out = 1;
                inara_out = 1;

                # API keys and commanders are managed through EDMC.
              }
              //
              # Pioneer plugin settings
              {
                pioneer_min_value = 500000;
                pioneer_shorten = false;
                pioneer_details = false;
                pioneer_biological = false;
                pioneer_map_counter = true;
              }
              //
              # BioScan plugin settings
              {
                bioscan_focus = "Near Surface";
                bioscan_scan_display = "Hide";
                bioscan_signal = "Always";
                bioscan_hide_body_complete = true;
                bioscan_box_height = 480;
              };
          };
        }
      );
    };
  }
