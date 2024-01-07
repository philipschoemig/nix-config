{
  lib,
  osConfig,
  ...
}: {
  services.blueman-applet.enable = osConfig.hardware.bluetooth.enable;

  dconf.settings = {
    "org/blueman/plugins/powermanager" = {
      # do not automatically power on bluetooth adapter
      auto-power-on = lib.hm.gvariant.mkJust false;
    };
  };
}
