{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;

      desktopManager = {
        # gnome.enable = true;
        xfce.enable = true;
        xterm.enable = false;
      };

      displayManager = {
        # gdm.enable = true;
        lightdm.enable = true;
      };

      xkb.layout = "de";
    };

    displayManager = {
      defaultSession = "xfce";
    };
  };

  # Enable GNOME Keyring daemon and install seahorse
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.polkit.enable = true;
  programs.seahorse.enable = true;

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
