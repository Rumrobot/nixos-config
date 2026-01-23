{ delib }:
(with delib.extensions; [
  args
  (delib.callExtension ./rice-options.nix)
  (base.withConfig {
    args.enable = true;

    # hosts.type.types = [
    #   "desktop"
    #   "server"
    # ];

    hosts.features = {
      # cli: Enables non-essential cli programs
      features = [
        "cli"
        "gui"
        "gaming"
        "development"
        "hacking"
        "powersave"
        "wireless"
      ];
      defaultByHostType = {
        desktop = [
          "cli"
          "gui"
          "development"
          "hacking"
        ];
        server = [ ];
      };
    };
  })
  (overlays.withConfig {
    defaultTargets = [
      "nixos"
    ];
  })
])
