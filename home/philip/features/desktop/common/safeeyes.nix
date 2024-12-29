{
  services = {
    safeeyes.enable = true;

    snixembed = {
      enable = true;
      beforeUnits = [
        # https://github.com/slgobinath/SafeEyes/wiki/How-to-install-backend-for-Safe-Eyes-tray-icon
        "safeeyes.service"
      ];
    };
  };
}
