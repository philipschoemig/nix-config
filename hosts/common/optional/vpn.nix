{ pkgs, ... }:

{
  networking.networkmanager = {
    plugins = with pkgs; [
      networkmanager-openvpn
      networkmanager-strongswan
    ];
  };

  environment.systemPackages = with pkgs; [
    strongswan
    wireguard-tools
  ];
}
