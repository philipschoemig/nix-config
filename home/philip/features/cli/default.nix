{ pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./direnv.nix
    ./git.nix
    ./neovim.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    timewarrior
  ];
}
