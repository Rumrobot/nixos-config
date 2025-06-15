self: super: {
  sunpaper = super.sunpaper.overrideAttrs (old: rec {
    postPatch =
      old.postPatch
      + ''
        substituteInPlace sunpaper.sh \
          --replace 'swww_enable="false"' 'swww_enable="true"' \
          --replace 'swww_fps="[^"]*"' 'swww_fps="5"' \
          --replace 'swww_step="[^"]*"' 'swww_step="5"'
      '';
  });
}
