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
