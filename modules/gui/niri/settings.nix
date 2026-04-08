{
  delib,
  host,
  ...
}:
delib.module {
  name = "gui.niri";

  home.ifEnabled = {
    programs.niri.settings = {
      outputs = builtins.listToAttrs (map (
          display: {
            name = display.name;
            value = {
              enable = display.enable;
              mode = {
                width = display.width;
                height = display.height;
                refresh = display.refreshRate * 1.0;
              };
              position = {
                x = display.x;
                y = display.y;
              };
            };
          }
        )
        host.displays);

      input.keyboard.xkb = {
        layout = "dk"; # TODO: Config variable
      };

      input.touchpad = {
        natural-scroll = true;
        click-method = "clickfinger";
        scroll-factor = 0.5;
      };

      window-rules = [
        {
          matches = [
            {
              app-id = "ghostty";
            }
          ];
          draw-border-with-background = false;
        }
      ];
    };
  };
}
