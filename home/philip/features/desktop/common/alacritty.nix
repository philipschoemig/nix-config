{
  programs.alacritty = {
    enable = true;
  };

  # Set as default terminal
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/terminal" = "Alacritty.desktop";
  };
}
