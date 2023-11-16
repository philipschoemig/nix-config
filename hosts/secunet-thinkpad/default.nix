{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/philip

    ../common/optional/browser.nix
    ../common/optional/laptop-battery.nix
    ../common/optional/office.nix
    ../common/optional/pipewire.nix
    ../common/optional/systemd-boot.nix
    ../common/optional/xserver.nix
  ];

  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices = {
    "nixos-enc" = {
      device = "/dev/nvme0n1p2";
      crypttabExtraOpts = ["fido2-device=auto"];
      # You may want to set preLVM to false if you need to start a network service first
      preLVM = true;
    };
  };

  # Necessary for the T14 Gen3 iris graphics, since they're not officially supported yet
  boot.kernelParams = ["i915.force_probe=46a6"];

  hardware.bluetooth.enable = true;

  networking.hostName = "secunet-thinkpad"; # Define your hostname.

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  services.fwupd.enable = true;

  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  services.thermald.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
