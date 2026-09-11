{
  delib,
  inputs,
  homeManagerUser,
  host,
  ...
}:
delib.module {
  name = "services.noctalia-greeter";

  options = delib.singleEnableOption false;

  nixos.always = {
    imports = [inputs.noctalia-greeter.nixosModules.default];
  };

  nixos.ifEnabled = {myconfig, ...}: let
    cursor = myconfig.rice.cursor;
    primaryOutputName = builtins.head (builtins.filter (d: d.primary) host.displays);
    outputLayout = builtins.concatStringsSep "; " (
      builtins.map (d: "${d.portName}:${builtins.toString d.x},${builtins.toString d.y}") (
        builtins.filter (d: d.enable) host.displays
      )
    );
  in {
    programs.noctalia-greeter = {
      enable = true;
      passwordless-sync-users = [homeManagerUser];
      settings = {
        output = {
          name = primaryOutputName;
          layout = outputLayout;
        };
        keyboard = {
          layout = myconfig.locale.keyboardLayout;
          options = myconfig.helpers.binds.keyboard.options;
        };
        cursor = {
          theme = cursor.name;
          size = cursor.size;
          path = "${cursor.package}/share/icons";
        };
        auth.allow_empty_password = myconfig.hardware.fingerprint.enable;
      };
    };
  };
}
