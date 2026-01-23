{
  inputs,
  delib,
  system,
  ...
}:
delib.overlayModule {
  name = "pkgs-stable";
  overlay =
    final: prev:
    let
      inherit (final) config;
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system config;
      };
    in
    {
      inherit pkgs-stable;
    };
}
