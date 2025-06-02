{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs # Node.js LTS version
  ];
}
