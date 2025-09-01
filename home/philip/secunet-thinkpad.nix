{
  imports = [
    ./global
    ./features/desktop/xfce
    ./features/development
  ];

  programs.git.userEmail = "philip.schoemig@secunet.com";

  conkyConfig = {
    enable = true;
    cpuTemp = ''''${hwmon coretemp temp 1}'';
    gpuModel = ''''${exec lspci -mm | awk -F '\"|\" \"|\\(' '/"Display|"3D|"VGA/ {print $3 " " $4}'}'';
    gpuFreq = ''''${exec grep -Po '\d+:\s\K(\d+)(?=.*\*$)' /sys/class/drm/card*/device/pp_dpm_sclk | head -1}'';
    gpuMemFreq = ''N/A'';
    gpuTemp = ''N/A'';
    ioTemp = ''''${hwmon nvme temp 1}'';
    networkWiredDevice = "enp0s31f6";
    networkWirelessDevice = "wlp0s20f3";
  };
}
