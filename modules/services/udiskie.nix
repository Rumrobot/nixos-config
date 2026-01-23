{ delib, host, pkgs, ... }:
delib.module {
  name = "service.udiskie";

  options = delib.singleEnableOption host.guiFeatured;

  nixos.ifEnabled = {
    services.udisks2.enable = true;
  };

  home.ifEnabled = {
    services.udiskie = {
      enable = true;
      settings = {
        # workaround for
        # https://github.com/nix-community/home-manager/issues/632
        program_options = {
          # replace with your favorite file manager
          file_manager = "${pkgs.thunar}/bin/thunar"; # TODO: Config variable
        };
      };
    };
  };
}
