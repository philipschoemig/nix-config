{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs-slim # Node.js LTS version, slim variant
  ];
}
