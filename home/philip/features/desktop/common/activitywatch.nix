{pkgs, ...}: let
  package = pkgs.activitywatch;
  application = "aw-qt";
in {
  home.packages = [
    package
  ];

  xdg.configFile."${application}" = {
    source = "${package}/share/applications/${application}.desktop";
    target = "autostart/${application}.desktop";
  };
}
