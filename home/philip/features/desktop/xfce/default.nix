{ pkgs, ... }:

{
  imports = [ ../common ];

  home.packages = with pkgs; [
    xfce.thunar-archive-plugin
    xfce.xfce4-pulseaudio-plugin
  ];
}
