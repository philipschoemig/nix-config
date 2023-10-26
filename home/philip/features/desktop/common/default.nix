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
  ];

  xdg.enable = true;
  xdg.mimeApps.enable = true;
}
