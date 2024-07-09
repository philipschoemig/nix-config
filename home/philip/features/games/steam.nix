{
  pkgs,
  osConfig,
  ...
}: let
  steamWithPkgs = pkgs.steam.override {
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

  steamDesktopEntry = {
    name =
      if osConfig.hardware.nvidia.prime.offload.enable
      then "Steam (Nvidia-Offload)"
      else "Steam";
    exec =
      if osConfig.hardware.nvidia.prime.offload.enable
      then "nvidia-offload steam %U"
      else "steam %U";
    icon = "steam";
    categories = [
      "Network"
      "FileTransfer"
      "Game"
    ];
    mimeType = [
      "x-scheme-handler/steam"
      "x-scheme-handler/steamlink"
    ];
  };
in {
  home.packages = with pkgs; [
    steamWithPkgs
    mangohud
    protontricks
    corefonts
  ];

  xdg.desktopEntries.steam = {
    inherit (steamDesktopEntry) name exec icon categories mimeType;
  };
}
