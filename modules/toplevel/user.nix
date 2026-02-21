{ delib, homeManagerUser, ... }:
delib.module {
  name = "user";

  nixos.always = {
    users = {
      groups.${homeManagerUser} = {};
      users.${homeManagerUser} = {
        isNormalUser = true;
        initialPassword = homeManagerUser;
        extraGroups = [ "wheel" ];
      };
    };
  };
}
