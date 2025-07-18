{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.nixosConfig.environment.terminals;
  terminals = cfg;

  defaultTerminals = lib.attrValues (
    lib.filterAttrs (name: value: value ? default && value.default) terminals
  );

  # TODO: Custom lib.optionalHead function
  # TODO: Make .terminal default if .terminals isnt present
  defaultTerminal =
    if defaultTerminals == []
    then null
    else builtins.head defaultTerminals;

  hasDefaultTerminal = defaultTerminal != null;
in {
  imports = [
    ./ghostty.nix
  ];

  config = mkIf hasDefaultTerminal {
    environment.sessionVariables = {
      TERMINAL = defaultTerminal.cmd;
    };

    assertions = [
      {
        assertion = lib.length defaultTerminals <= 1;
        message = "You have more than one default terminal: ${lib.concatStringsSep " " (lib.map (br: br.name) defaultTerminals)}";
      }
    ];
  };
}
