{ ... }: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
    ./configuration.nix
  ];

  nixosConfig = {
    windowManagers.hyprland.enable = true;
    system = {
      keymap = {
        layout = "dk";
        variant = "latin1";
      };
    };
  };

  ne = {
    desktop.ags.enable = true;
    programs = {
      neovim.enable = true;
    };
  };
}
