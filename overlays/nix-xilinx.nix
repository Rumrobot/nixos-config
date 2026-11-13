{
  inputs,
  delib,
  ...
}:
delib.overlayModule {
  name = "nix-xilinx";

  enabled = false;

  overlay = final: prev: let
    xilinx = (import "${inputs.nix-xilinx}/flake.nix").outputs (inputs.nix-xilinx.inputs
      // {
        self = xilinx;
        nixpkgs =
          inputs.nixpkgs
          // {
            legacyPackages.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.extend (final: prev: {
              # gtk2 is deprecated, so replace it with gtk3
              gtk2 = final.gtk3;
            });
          };
      });
  in
    xilinx.overlay final prev;
}
