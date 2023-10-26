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
    pavucontrol
    pulseaudio # pacmd and pactl
  ];

  xdg.enable = true;
}
