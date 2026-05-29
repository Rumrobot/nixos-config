# Reference configs:
#   - https://github.com/ch1bo/dotfiles/blob/master/home-modules/browser/zen.nix
#   - https://github.com/luisnquin/nixos-config/blob/main/home/modules/programs/browser/zen/default.nix
#   - https://github.com/skifli/nixos/blob/main/users/programs/browser/zen.nix
{
  delib,
  host,
  inputs,
  homeManagerUser,
  ...
}:
delib.module {
  name = "programs.browsers.zen";

  options = delib.singleEnableOption host.guiFeatured;

  home.ifEnabled = {
    imports = [inputs.zen-browser.homeModules.beta]; # beta / twilight / twilight-official

    # Use legacy profile mode to avoid needing machine-specific Install identifier
    home.sessionVariables.MOZ_LEGACY_PROFILES = "1";

    programs.zen-browser = {
      enable = true;

      policies = let
        lock = value: {
          Value = value;
          Status = "locked";
        };
      in {
        # Use external manager instead
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        OfferToSaveLogins = false;

        DisableAppUpdate = true;
        DisableTelemetry = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        SanitizeOnShutdown = {
          FormData = true;
          Cache = true;
        };

        # Locked preferences (cannot be changed in about:config)
        Preferences = {
          "browser.aboutConfig.showWarning" = lock false;
          "browser.tabs.warnOnClose" = lock false;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = lock true;
          "browser.tabs.hoverPreview.enabled" = lock true;
          "browser.newtabpage.activity-stream.feeds.topsites" = lock false;
          "browser.topsites.contile.enabled" = lock false;

          # Privacy hardening
          "privacy.resistFingerprinting" = lock true;
          "privacy.resistFingerprinting.testing.setTZtoUTC" = lock false; # Keep local timezone
          "privacy.resistFingerprinting.randomization.canvas.use_siphash" = lock true;
          "privacy.resistFingerprinting.randomization.daily_reset.enabled" = lock true;
          "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = lock true;
          "privacy.resistFingerprinting.block_mozAddonManager" = lock true;
          "privacy.spoof_english" = lock 1;

          # Isolates cookies, cache, and storage per first-party domain.
          # Cross-site SSO may require re-authentication.
          "privacy.firstparty.isolate" = lock true;

          "network.cookie.cookieBehavior" = lock 5; # Total Cookie Protection
          "dom.battery.enabled" = lock false;

          # Performance
          "gfx.webrender.all" = lock true;
          "network.http.http3.enabled" = lock true;

          # Network security
          "network.socket.ip_addr_any.disabled" = lock true; # Disallow binding to 0.0.0.0
        };
      };

      profiles.${homeManagerUser} = rec {
        id = 0;
        isDefault = true;

        settings = {
          "zen.workspaces.continue-where-left-off" = true;
          # "zen.workspaces.natural-scroll" = true;
          "zen.view.compact.animate-sidebar" = true;
          "zen.welcome-screen.seen" = true;
          "zen.urlbar.behavior" = "float";
          "browser.tabs.closeWindowWithLastTab" = false;

          # Disable zen's own theming so stylix colors show through
          "zen.theme.gradient" = false;
          "zen.theme.color-prefs" = "";
          "zen.themes.updated-value-observer" = false;
        };

        # Betterfox: comprehensive Firefox hardening + performance tuning
        # https://github.com/yokoffing/Betterfox
        extraConfig = ''
          // Betterfox
          ${builtins.readFile "${inputs.betterfox}/Fastfox.js"}
          ${builtins.readFile "${inputs.betterfox}/Securefox.js"}
          ${builtins.readFile "${inputs.betterfox}/Peskyfox.js"}

          // Keep Firefox Sync enabled (Betterfox disables it by default)
          user_pref("identity.fxaccounts.enabled", true);
        '';

        # Zen mods
        mods = [
          "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8" # No Sidebar Scrollbar
          "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
          "cb15abdb-0514-4e09-8ce5-722cf1f4a20f" # Hide Extension Name
          "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
          "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better Unloaded Tabs
        ];

        # Keyboard shortcuts
        keyboardShortcutsVersion = 17; # Pin to detect regressions on zen updates
        keyboardShortcuts = [
          {
            id = "key_quitApplication";
            disabled = true; # Prevent accidental Ctrl+Q close
          }
        ];

        search = {
          force = true;
          default = "ddg"; # DuckDuckGo
          engines = {
            "nixpkgs" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["p" "np"];
            };

            "nix-options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = ["o" "no"];
            };

            "hm-options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    {
                      name = "release";
                      value = "master";
                    }
                  ];
                }
              ];
              definedAliases = ["hm" "hmo"];
            };

            "maps" = {
              urls = [
                {
                  template = "http://maps.google.com";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [
                "maps"
                "gmaps"
              ];
            };

            "youtube" = {
              urls = [
                {
                  template = "https://www.youtube.com/results";
                  params = [
                    {
                      name = "search_query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [
                "y"
                "yt"
              ];
            };

            bing.metaData.hidden = "true";
          };
        };
      };
    };

    # Default browser MIME associations
    xdg.mimeApps = let
      associations = builtins.listToAttrs (
        map
        (name: {
          inherit name;
          value = "zen-beta.desktop";
        })
        [
          "application/x-extension-shtml"
          "application/x-extension-xhtml"
          "application/x-extension-html"
          "application/x-extension-xht"
          "application/x-extension-htm"
          "x-scheme-handler/unknown"
          "x-scheme-handler/mailto"
          "x-scheme-handler/chrome"
          "x-scheme-handler/about"
          "x-scheme-handler/https"
          "x-scheme-handler/http"
          "application/xhtml+xml"
          "application/json"
          "text/plain"
          "text/html"
        ]
      );
    in {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };

    stylix.targets.zen-browser.profileNames = [homeManagerUser];
  };
}
