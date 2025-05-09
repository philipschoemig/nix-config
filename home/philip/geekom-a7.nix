{
  imports = [
    ./global
    ./features/accounts/posteo.nix
    ./features/development
    ./features/desktop/xfce
    ./features/games
    ./features/productivity
    ./features/social
    ./features/virtualization
  ];

  conkyConfig = {
    enable = true;
    cpuTemp = ''''${hwmon k10temp temp 1}'';
    gpuModel = '''';
    gpuFreq = ''''${exec grep -Po '\d+:\s\K(\d+)(?=.*\*$)' /sys/class/drm/card*/device/pp_dpm_sclk | head -1}'';
    gpuMemFreq = ''''${exec grep -Po '\d+:\s\K(\d+)(?=.*\*$)' /sys/class/drm/card*/device/pp_dpm_mclk | head -1}'';
    gpuTemp = ''''${hwmon amdgpu temp 1}'';
    ioTemp = ''''${hwmon nvme temp 1}'';
    networkWiredDevice = "enp1s0";
    networkWirelessDevice = "wlp2s0";
  };
}
