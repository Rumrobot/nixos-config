{
  pkgs,
  delib,
  ...
}:
delib.overlayModule {
  name = "nautilus-gstreamer";

  enabled = false;

  overlay = final: prev: let
    nautilus = prev.nautilus.overrideAttrs (nprev: {
      buildInputs =
        nprev.buildInputs
        ++ (with pkgs.gst_all_1; [
          gst-plugins-good
          gst-plugins-bad
        ]);
    });
  in {
    inherit nautilus;
  };
}
