{ pkgs, ... }:

{
  imports = [
    ./vscode
    ./chromium.nix
    ./firefox.nix
    ./keepassxc.nix
    ./ssh-agent.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    pavucontrol # Volume control
    pulseaudio # Sound server
    qimgv # Image viewer
    xarchiver # Archiver front end
  ];

  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "application/zip" = [ "xarchiver.desktop" ];
      "image/*" = [ "qimgv.desktop" ];
      "image/png" = [ "qimgv.desktop" ];
      "image/jpeg" = [ "qimgv.desktop" ];
    };
  };
}
