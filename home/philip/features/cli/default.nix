{ pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./neovim.nix
    ./starship.nix
    ./zellij.nix
  ];

  home.packages = with pkgs; [
    ### Nix tools ###
    nixfmt-rfc-style # Nix formatter
    statix # Nix linter

    libqalculate # Calculator (CLI of qalculate)

    ltex-ls # Spell checking language server

    shfmt # Shell parser and formatter

    timewarrior # Time tracker
  ];
}
