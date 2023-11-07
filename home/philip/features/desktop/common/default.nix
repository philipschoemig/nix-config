{pkgs, ...}: {
  imports = [
    ./vscode
    ./activitywatch.nix
    ./chromium.nix
    ./firefox.nix
    ./keepassxc.nix
    ./ssh-agent.nix
    ./thunderbird.nix
    ./zathura.nix
  ];

  home.packages = with pkgs; [
    pavucontrol # Volume control
    pulseaudio # Sound server
    qalculate-gtk # Calculator
    qimgv # Image viewer
    qownnotes # Notes manager
    xarchiver # Archiver front end
  ];

  services.safeeyes.enable = true;

  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "application/x-archive" = ["xarchiver.desktop"];
      "application/zip" = ["xarchiver.desktop"];
      "image/*" = ["qimgv.desktop"];
      "image/jpeg" = ["qimgv.desktop"];
      "image/png" = ["qimgv.desktop"];
    };
  };
}
