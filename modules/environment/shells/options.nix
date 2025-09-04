{
  lib,
  name,
  package ? null,
}:
with lib; {
  enable = mkEnableOption "${name} shell";
  default = mkEnableOption "Make ${name} the default shell";

  package = mkOption {
    type = types.package;
    default = package;
  };

  name = mkOption {
    type = types.str;
    default = name;
  };
}
