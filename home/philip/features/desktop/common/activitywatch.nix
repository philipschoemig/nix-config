{pkgs, ...}: let
  inherit (pkgs.lib.strings) fileContents;

  package = pkgs.activitywatch;
  application = "aw-qt";
in {
  home.packages = [
    package
  ];

  # TODO: use xdg.desktopEntries (https://nix-community.github.io/home-manager/options.html#opt-xdg.desktopEntries) instead?
  xdg.configFile."${application}" = {
    text = builtins.replaceStrings ["Exec=aw-qt"] ["Exec=sh -c \"sleep 5 && aw-qt\""] (
      fileContents "${pkgs.aw-qt}/share/applications/${application}.desktop"
    );
    target = "autostart/${application}.desktop";
  };
}
