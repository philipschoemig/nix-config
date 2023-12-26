{pkgs, ...}: {
  home.packages = with pkgs; [
    calibre # E-book software
    evince # Document viewer
  ];
}
