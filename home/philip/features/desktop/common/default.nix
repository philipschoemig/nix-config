{pkgs, ...}: {
  imports = [
    ./vscode
    ./activitywatch.nix
    ./autorandr.nix
    ./blueman.nix
    ./chromium.nix
    ./firefox.nix
    ./keepassxc.nix
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
      components = ["pkcs11" "secrets" "ssh"];
    };

    safeeyes.enable = true;
  };

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
