{ pkgs, ... }:

{
  services.kmscon = {
    enable = true;
    hwRender = true;
    # agetty call based on https://fedoraproject.org/wiki/Changes/UseKmsconVTConsole#How_To_Test
    extraOptions = ''
      --xkb-layout=de --login -- \
      ${pkgs.util-linux}/bin/agetty --noclear --login-options '-p -- \u' -- -
    '';
    fonts = [
      {
        name = "FiraCode Nerd Font Mono Regular";
        package = pkgs.nerd-fonts.fira-code;
      }
    ];
  };
}
