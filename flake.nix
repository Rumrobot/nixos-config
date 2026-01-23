{
  description = "Modular NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    inputs.awww.url = "git+https://codeberg.org/LGFae/awww";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

    vicinae.url = "github:vicinaehq/vicinae";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };

    _1password-shell-plugins.url = "github:1Password/shell-plugins";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpaper-daemon.url = "path:/home/ne/Github/wallpaper-daemon";
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://vicinae.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };

  outputs =
    inputs @ {
      denix,
      nixpkgs,
      nixpkgs-stable,
      ...
    }: let
     mkConfigurations =
      moduleSystem:
      denix.lib.configurations rec {
        inherit moduleSystem;
        homeManagerUser = "ne";

        paths = [
          ./hosts
          ./modules
          ./rices
          ./overlays
        ];

        extensions = import ./extensions { delib = denix.lib; };

        specialArgs = {
          inherit
            inputs
            moduleSystem
            homeManagerUser
            ;
          };
        };
    in
    {
      nixosConfigurations = mkConfigurations "nixos";
      homeConfigurations = mkConfigurations "home";
    };
}
