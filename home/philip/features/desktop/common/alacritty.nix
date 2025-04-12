{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dimensions = {
          columns = 120;
          lines = 36;
        };
      };
      keyboard = {
        bindings = [
          {
            key = "N";
            mods = "Control|Shift";
            action = "SpawnNewInstance";
          }
          {
            key = "N";
            mods = "Control";
            action = "CreateNewWindow";
          }
          {
            key = "F";
            mods = "Control";
            mode = "~Search";
            action = "SearchForward";
          }
          {
            key = "B";
            mods = "Control";
            mode = "~Search";
            action = "SearchBackward";
          }
        ];
      };
    };
  };

  # Set as default terminal
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/terminal" = "Alacritty.desktop";
  };
}
