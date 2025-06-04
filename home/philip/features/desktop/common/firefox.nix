{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles."default" = {
      isDefault = true;

      extensions.packages = with pkgs.inputs.firefox-addons; [
        ghostery
        keepassxc-browser
        leechblock-ng
      ];

      search.default = "Startpage";
      search.force = true;

      search.engines = {
        "Startpage" = {
          urls = [ { template = "https://www.startpage.com/sp/search?query={searchTerms}"; } ];
          icon = "https://www.startpage.com/sp/cdn/favicons/favicon-16x16--default.png";
          definedAliases = [ "@startpage" ];
        };

        "SearXNG" = {
          urls = [ { template = "https://search.sapti.me/search?q={searchTerms}"; } ];
          icon = "https://search.sapti.me/static/themes/simple/img/favicon.png";
          definedAliases = [ "@searx" ];
        };

        "SearXNG Alternative" = {
          urls = [ { template = "https://search.demoniak.ch/search?q={searchTerms}"; } ];
          icon = "https://search.demoniak.ch/static/themes/simple/img/favicon.png";
          definedAliases = [ "@searx-alt" ];
        };

        "NixOS Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nixpkgs" ];
        };

        "NixOS Options" = {
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nixopts" ];
        };

        "NixOS Wiki" = {
          urls = [ { template = "https://nixos.wiki/index.php?search={searchTerms}"; } ];
          icon = "https://nixos.wiki/favicon.png";
          definedAliases = [ "@nixwiki" ];
        };

        "Home-Manager Options" = {
          urls = [ { template = "https://home-manager-options.extranix.com/?query={searchTerms}"; } ];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@homemanager" ];
        };

        "Rust Crates" = {
          urls = [ { template = "https://crates.io/search?q={searchTerms}"; } ];
          icon = "https://crates.io/favicon.ico";
          definedAliases = [ "@rustcrates" ];
        };

        "Rust Docs" = {
          urls = [ { template = "https://docs.rs/releases/search?query={searchTerms}"; } ];
          icon = "https://docs.rs/-/rustdoc.static/favicon-32x32-422f7d1d52889060.png";
          definedAliases = [ "@rustdocs" ];
        };

        "dict.cc Dictionary" = {
          urls = [ { template = "https://www.dict.cc/?s={searchTerms}"; } ];
          icon = "https://www4.dict.cc/img/favicons/favicon4.png";
          definedAliases = [ "@dictcc" ];
        };
      };

      # See https://kb.mozillazine.org/About:config
      settings = {
        "browser.startup.page" = 3; # Resume the previous browser session
        "privacy.clearOnShutdown.cache" = true;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.history" = false; # Needed to keep tabs open
        "privacy.clearOnShutdown.offlineApps" = false;
        "privacy.clearOnShutdown.openWindows" = false;
        "privacy.clearOnShutdown.sessions" = true;
        "privacy.clearOnShutdown.siteSettings" = false;
        "privacy.history.custom" = true;
        "privacy.sanitize.sanitizeOnShutdown" = true;
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
