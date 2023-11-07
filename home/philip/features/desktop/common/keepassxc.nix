{pkgs, ...}: let
  package = pkgs.keepassxc;
  application = "org.keepassxc.KeePassXC";
in {
  home.packages = [
    package
  ];

  xdg.configFile."${application}" = {
    source = "${package}/share/applications/${application}.desktop";
    target = "autostart/${application}.desktop";
  };
}
