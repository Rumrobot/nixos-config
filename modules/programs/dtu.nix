{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.dtu";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs.development = {
      java.enable = true;
      python.enable = true;
    };
  };

  home.ifEnabled = {
    home.packages = with pkgs; [
      ltspice # Electronics simulator
      logisim # Digital electronics simulator
    ];

    programs = {
      git.includes = [
        {
          condition = "hasconfig:remote.*.url:git@gitlab.gbar.dtu.dk:**";
          contents = {
            user = {
              name = "s265172";
              email = "s265172@student.dtu.dk";
              signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcgjELhorYRWrbhR35yd69scBEACj1jT2Mw2FYBQN3O";
            };
          };
        }
      ];
    };
  };
}
