{ pkgs, ... }:
{
  imports = [
    ./activitywatch.nix
    ./alacritty.nix
    ./autorandr.nix
    ./blueman.nix
    ./chromium.nix
    ./firefox.nix
    ./keepassxc.nix
    ./safeeyes.nix
    ./ssh-agent.nix
    ./thunderbird.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    element-desktop # Element/Matrix client
    pavucontrol # Volume control
    pulseaudio # Sound server
    qalculate-gtk # Calculator
    qimgv # Image viewer
    qownnotes # Notes manager
    xarchiver # Archiver front end
  ];

  services = {
    gnome-keyring = {
      enable = true;
      components = [
        "pkcs11"
        "secrets"
        "ssh"
      ];
    };
  };

  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "application/x-7z-compressed" = [ "xarchiver.desktop" ];
      "application/x-archive" = [ "xarchiver.desktop" ];
      "application/x-bzip" = [ "xarchiver.desktop" ];
      "application/x-bzip2" = [ "xarchiver.desktop" ];
      "application/x-gzip" = [ "xarchiver.desktop" ];
      "application/x-tar" = [ "xarchiver.desktop" ];
      "application/gzip" = [ "xarchiver.desktop" ];
      "application/zip" = [ "xarchiver.desktop" ];
      "image/*" = [ "qimgv.desktop" ];
      "image/jpeg" = [ "qimgv.desktop" ];
      "image/png" = [ "qimgv.desktop" ];
      "x-scheme-handler/io.element.desktop" = "element-desktop.desktop";
    };
  };
}
