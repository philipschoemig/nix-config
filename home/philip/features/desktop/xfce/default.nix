{ pkgs, ... }:

{
  imports = [ ../common ];

  home.packages = with pkgs.xfce; [
    catfish
  ];
}
