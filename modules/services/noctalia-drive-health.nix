{
  delib,
  pkgs,
  homeconfig,
  ...
}: let
  noctaliaDriveHealthPath = "${homeconfig.home.homeDirectory}/.local/state/noctalia/plugins/materialized/community/drive-health";
in
  delib.module {
    # Noctalia plugin id: gustav0ar/drive-health
    # https://github.com/noctalia-dev/community-plugins/tree/main/drive-health

    name = "services.noctalia-drive-health";

    options = delib.singleEnableOption false;

    nixos.ifEnabled = {
      systemd.services.noctalia-drive-health = {
        description = "Collect read-only SMART data for Noctalia Drive Health";
        documentation = ["man:smartctl(8)"];

        wantedBy = ["multi-user.target"];
        after = ["local-fs.target"];

        path = with pkgs; [
          util-linux
          smartmontools
          coreutils
          gnused
        ];

        serviceConfig = {
          Type = "oneshot";
          ExecStart = "/bin/sh ${noctaliaDriveHealthPath}/scripts/collect_raw.sh --output /run/noctalia-drive-health/raw.json";
          Group = "users";
          RuntimeDirectory = "noctalia-drive-health";
          RuntimeDirectoryMode = "0750";
          RuntimeDirectoryPreserve = "yes";
          UMask = "0027";
          StandardOutput = "null";
          StandardError = "journal";
          TimeoutStartSec = "60s";
          NoNewPrivileges = true;
          PrivateTmp = true;
          PrivateNetwork = true;
          ProtectSystem = "strict";
          ProtectHome = "tmpfs";
          BindReadOnlyPaths = [
            noctaliaDriveHealthPath
          ];
          ProtectHostname = true;
          ProtectKernelLogs = true;
          ProtectKernelTunables = true;
          ProtectKernelModules = true;
          ProtectControlGroups = true;
          ProtectClock = true;
          RestrictAddressFamilies = ["AF_UNIX"];
          RestrictNamespaces = true;
          RestrictRealtime = true;
          RestrictSUIDSGID = true;
          SystemCallArchitectures = "native";
          LockPersonality = true;
          MemoryDenyWriteExecute = true;
          CapabilityBoundingSet = [
            "CAP_DAC_OVERRIDE"
            "CAP_SYS_ADMIN"
            "CAP_SYS_RAWIO"
          ];
          ReadWritePaths = ["/run/noctalia-drive-health"];
        };
      };

      systemd.timers.noctalia-drive-health = {
        description = "Refresh SMART data for Noctalia";

        wantedBy = ["timers.target"];

        timerConfig = {
          OnBootSec = "20s";
          OnUnitActiveSec = "15min";
          AccuracySec = "5s";
          Unit = "noctalia-drive-health.service";
        };
      };
    };
  }
