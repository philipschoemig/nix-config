{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./direnv.nix
    ./git.nix
    ./neovim.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    ### Nix tools ###
    alejandra # Nix formatter
    nil # Nix language server
    statix # Nix linter

    libqalculate # Calculator (CLI of qalculate)

    ltex-ls # Spell checking language server

    shfmt # Shell parser and formatter

    timewarrior # Time tracker
  ];
}
