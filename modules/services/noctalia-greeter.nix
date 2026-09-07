{
  delib,
  inputs,
  homeManagerUser,
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
  in {
    programs.noctalia-greeter = {
      enable = true;
      settings = {
        passwordless-sync-users = [homeManagerUser];
        keyboard = {
          layout = myconfig.locale.keyboardLayout;
          options = myconfig.helpers.binds.keyboard.options;
        };
        cursor = {
          theme = cursor.name;
          size = cursor.size;
          path = "${cursor.package}/share/icons";
        };
      };
    };
  };
}
