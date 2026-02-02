{ pkgs, ... }:

{
  imports = [ ./xserver.nix ];

  services = {
    xserver = {
      desktopManager = {
        kodi = {
          enable = true;
          package = pkgs.kodi.withPackages (
            pkgs: with pkgs; [
              bluetooth-manager
              jellyfin
              mediathekview
              pvr-iptvsimple
              vfs-sftp
              visualization-matrix
              youtube
            ]
          );
        };
      };
    };

    displayManager.autoLogin = {
      enable = true;
      user = "kodi";
    };
  };

  users.users.kodi.isNormalUser = true;
}
