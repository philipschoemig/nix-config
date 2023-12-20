{pkgs, ...}: {
  home.packages = with pkgs; [
    quickemu # Quickly create and run optimised desktop virtual machines
    quickgui # Frontend for quickemu
  ];
}
