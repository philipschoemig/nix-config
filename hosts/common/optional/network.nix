{
  boot.kernelModules = [ "rtl8xxxu" ];

  # Enable support for certain USB WLAN and WWAN adapters
  hardware.usb-modeswitch.enable = true;

  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
}
