{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../common/global
      ../common/users/philip

      ../common/optional/office.nix
      ../common/optional/pipewire.nix
      ../common/optional/systemd-boot.nix
      ../common/optional/xserver.nix
    ];

  networking.hostName = "lenovo-yoga";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  powerManagement.powertop.enable = true;

  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  services.printing.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
