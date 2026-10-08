{
  inputs,
  delib,
  ...
}:
delib.overlayModule {
  name = "nix-vscode-extensions";

  enabled = false;

  overlay = inputs.nix-vscode-extensions.overlays.default;
}
