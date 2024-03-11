{pkgs, ...}: let
  steam-with-pkgs = pkgs.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        mangohud
        corefonts
      ];
  };
in {
  home.packages = with pkgs; [
    steam-with-pkgs
    mangohud
    protontricks
    corefonts
  ];

  xdg.desktopEntries.steam = {
    name = "Steam (Nvidia-Offload)";
    exec = "nvidia-offload steam";
  };
}
