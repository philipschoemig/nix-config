{ pkgs, ... }:

{
  imports = [ ../common ];

  home.packages = with pkgs.xfce; [
    catfish # XFCE file search tool
  ];

  xfconf.settings = {
    xfce4-session = {
      "compat/LaunchGNOME" = true;
    };
    xfwm4 = {
      "general/activate_action" = "none";
    };
  };
}
