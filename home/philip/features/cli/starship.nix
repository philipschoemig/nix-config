{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
}
