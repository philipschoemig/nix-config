{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
}
