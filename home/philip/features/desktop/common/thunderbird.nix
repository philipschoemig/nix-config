{
  programs.thunderbird = {
    enable = true;

    profiles."default" = {
      isDefault = true;
    };
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/mailto" = ["thunderbird.desktop"];
  };
}
