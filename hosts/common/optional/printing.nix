{pkgs, ...}: {
  hardware.sane = {
    enable = true;
    extraBackends = [pkgs.sane-airscan];
  };

  # Required to fix CUPS error messages about ColorManager
  services.colord.enable = true;

  # Enable autodiscovery of network printers, see https://nixos.wiki/wiki/Printing#Enable_autodiscovery_of_network_printers
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cnijfilter2 # Canon InkJet printer drivers
    ];
  };

  environment.systemPackages = with pkgs; [
    paperwork
  ];
}
