{ pkgs, ... }:

{
  imports = [ ../common ];

  home.packages = with pkgs.xfce; [
    catfish # XFCE file search tool
  ];

  home.file.".config/xfce4/helpers.rc".text = ''
    TerminalEmulator=alacritty
    WebBrowser=firefox
  '';

  xfconf.settings = {
    xfce4-session = {
      "compat/LaunchGNOME" = true;
    };
    xfwm4 = {
      "general/activate_action" = "none";
    };
  };
}
