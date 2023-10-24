{ inputs, lib, pkgs, config, outputs, ... }:

{
  imports = [
    ./direnv.nix
    ./firefox.nix
    ./git.nix
    ./keepassxc.nix
    ./neovim.nix
    ./zathura.nix
    ./bash
    ./vscode
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    };
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "philip";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "$HOME/Projects/github.com/philipschoemig/nix-config";
    };
  };
}
