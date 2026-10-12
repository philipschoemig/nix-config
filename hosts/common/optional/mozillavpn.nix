{ pkgs, ... }:

{
  # Enable the Mozilla VPN daemon
  services.mozillavpn.enable = true;

  # Note: If your traffic drops completely after connecting,
  # you may need to loosen reverse path filtering in the firewall:
  # networking.firewall.checkReversePath = "loose";

  environment.systemPackages = with pkgs; [
    mozillavpn
  ];
}
