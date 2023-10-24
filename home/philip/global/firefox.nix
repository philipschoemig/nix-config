{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles."default" = {
      isDefault = true;

      search.default = "SearXNG";
      search.force = true;

      search.engines = {
        "SearXNG" = {
          urls = [{ template = "https://searx.be/search?q={searchTerms}"; }];
          iconUpdateURL = "https://searx.be/static/themes/oscar/img/favicon.png";
          definedAliases = [ "@searx" ];
        };

        "Startpage" = {
          urls = [{ template = "https://www.startpage.com/sp/search?query={searchTerms}"; }];
          iconUpdateURL = "https://www.startpage.com/sp/cdn/favicons/favicon-16x16--default.png";
          definedAliases = [ "@startpage" ];
        };

        "NixOS Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nixpkgs" ];
        };

        "NixOS Options" = {
          urls = [{
            template = "https://search.nixos.org/options";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@nixopts" ];
        };

        "NixOS Wiki" = {
          urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
          iconUpdateURL = "https://nixos.wiki/favicon.png";
          definedAliases = [ "@nixwiki" ];
        };

        "Home-Manager Options" = {
          urls = [{ template = "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}"; }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@homemanager" ];
        };

        "Rust Crates" = {
          urls = [{ template = "https://crates.io/search?q={searchTerms}"; }];
          iconUpdateURL = "https://crates.io/favicon.ico";
          definedAliases = [ "@rustcrates" ];
        };

        "Rust Docs" = {
          urls = [{ template = "https://docs.rs/releases/search?query={searchTerms}"; }];
          iconUpdateURL = "https://docs.rs/-/rustdoc.static/favicon-32x32-422f7d1d52889060.png";
          definedAliases = [ "@rustdocs" ];
        };

        "dict.cc Dictionary" = {
          urls = [{ template = "https://www.dict.cc/?s={searchTerms}"; }];
          iconUpdateURL = "https://www4.dict.cc/img/favicons/favicon4.png";
          definedAliases = [ "@dictcc" ];
        };
      };
    };
  };
}