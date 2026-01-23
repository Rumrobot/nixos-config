{ delib }:
(with delib.extensions; [
  args
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
  (delib.callExtension ./rice-options.nix)
])
