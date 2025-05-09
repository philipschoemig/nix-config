{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
