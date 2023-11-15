{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/philip

    ../common/optional/laptop-battery.nix
    ../common/optional/office.nix
    ../common/optional/password-manager.nix
    ../common/optional/pipewire.nix
    ../common/optional/printing.nix
    ../common/optional/smartcard.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/xserver.nix
  ];

  hardware.bluetooth.enable = true;

  networking.hostName = "lenovo-yoga";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  programs = {
    light.enable = true;
    dconf.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  services.fwupd.enable = true;

  services.thermald.enable = true;

  # Enable battery conservation mode
  services.tlp.settings.START_CHARGE_THRESH_BAT0 = 0; # dummy value
  services.tlp.settings.STOP_CHARGE_THRESH_BAT0 = 1; # batteries charges to 60%

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
