{delib, ...}:
delib.module {
  name = "hardware.logitech-g502";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    # Avoid overly sensitive scrolling and wheel bounce for the Logitech G502
    environment.etc."libinput/local-overrides.quirks".text = ''
      [Logitech G502 discrete wheel scrolling]
      MatchName=Logitech G502
      AttrEventCode=-REL_WHEEL_HI_RES;-REL_HWHEEL_HI_RES;
    '';
  };
}
