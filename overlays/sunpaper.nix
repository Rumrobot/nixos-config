self: super: {
  sunpaper = super.sunpaper.overrideAttrs (old: rec {
    patchPhase =
      old.patchPhase
      + ''
        substituteInPlace sunpaper.sh \
          --replace 'swww_enable="false"' 'swww_enable="true"'
        substituteInPlace sunpaper.sh \
          --replace 'swww_fps="[^"]*"'   'swww_fps="5"'
        substituteInPlace sunpaper.sh \
          --replace 'swww_step="[^"]*"'  'swww_step="5"'
      '';
  });
}
