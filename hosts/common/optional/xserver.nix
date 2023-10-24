{
  services = {
    xserver = {
      enable = true;

      desktopManager.gnome.enable = true;
      desktopManager.xfce.enable = true;

      # displayManager.gdm.enable = true;
      displayManager.lightdm.enable = true;

      layout = "de";
    };
  };
}
