{
  delib,
  lib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "programs.desktop.qimgv";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled = {
    home.packages = [pkgs.qimgv];

    xdg.mimeApps = {
      enable = true;
      defaultApplications = lib.genAttrs [
        # Standard formats
        "image/jpeg"
        "image/png"
        "image/webp"
        "image/gif"
        "image/bmp"
        "image/tiff"
        "image/svg+xml"

        # Camera RAW formats
        "image/x-adobe-dng"
        "image/x-canon-cr2"
        "image/x-canon-cr3"
        "image/x-nikon-nef"
        "image/x-sony-arw"
        "image/x-fuji-raf"
        "image/x-olympus-orf"
        "image/x-panasonic-rw2"
        "image/x-pentax-pef"
        "image/x-minolta-mrw"
        "image/x-sigma-x3f"
        "image/x-dcraw"
      ] (_: ["qimgv.desktop"]);
    };
  };
}
