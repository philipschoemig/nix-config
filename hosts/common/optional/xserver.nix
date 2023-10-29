{
  config,
  pkgs,
  ...
}: {
  services = {
    xserver = {
      enable = true;

      desktopManager = {
        # gnome.enable = true;
        xfce.enable = true;
        xterm.enable = false;
      };

      displayManager = {
        defaultSession = "xfce";
        # gdm.enable = true;
        lightdm.enable = true;
      };

      layout = "de";
    };
  };

  services.blueman.enable = config.hardware.bluetooth.enable;

  # Enable GNOME Keyring daemon and automatically unlock the keyring upon login
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.lightdm.enableGnomeKeyring = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-media-tags-plugin
      thunar-volman
    ];
  };

  environment.systemPackages = with pkgs.xfce; [
    xfce4-pulseaudio-plugin
  ];
}
