{ pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;

      desktopManager = {
        # gnome.enable = true;
        xfce.enable = true;
        xterm.enable = false;
      };

      displayManager.defaultSession = "xfce";
      # displayManager.gdm.enable = true;
      displayManager.lightdm.enable = true;

      layout = "de";
    };
  };

  environment.systemPackages = with pkgs; [
    xfce.thunar-archive-plugin
    xfce.xfce4-pulseaudio-plugin
  ];
}
