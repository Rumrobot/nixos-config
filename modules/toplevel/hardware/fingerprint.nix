{
  delib,
  pkgs,
  config,
  ...
}: let
  # exit 0 when the lid is open (fingerprint), exit 1 when closed (password)
  lidCheck = pkgs.writeShellScript "fprint-lid-check" ''
    state=$(cat /proc/acpi/button/lid/*/state 2>/dev/null | head -n1)
    case "$state" in
      *closed*) exit 1 ;;
    esac
    exit 0
  '';
in
  delib.module {
    name = "hardware.fingerprint";

    options = delib.singleEnableOption false;

    nixos.ifEnabled = {
      services.fprintd.enable = true;

      services.logind.settings.Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
      };

      # Skip fingerprint PAM step when the lid is closed
      security.pam.services = let
        lidGated = svc: {
          fprintAuth = true;
          rules.auth.fingerprint-check = {
            order = config.security.pam.services.${svc}.rules.auth.fprintd.order - 10;
            control = "[success=ignore default=1]";
            modulePath = "${pkgs.pam}/lib/security/pam_exec.so";
            args = ["quiet" "${lidCheck}"];
          };
        };
      in {
        sudo = lidGated "sudo";
        polkit-1 = lidGated "polkit-1";
        login = lidGated "login";
      };
    };
  }
