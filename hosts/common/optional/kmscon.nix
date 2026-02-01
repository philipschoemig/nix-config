{ pkgs, ... }:

{
  services.kmscon = {
    enable = true;
    hwRender = true;
    extraConfig = ''
      xkb-layout=de
    '';
    fonts = [
      {
        name = "FiraCode Nerd Font Mono Regular";
        package = pkgs.nerd-fonts.fira-code;
      }
    ];
  };
}
