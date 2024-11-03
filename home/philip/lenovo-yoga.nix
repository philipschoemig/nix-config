{
  imports = [
    ./global
    ./features/accounts/posteo.nix
    ./features/desktop/xfce
    ./features/games
    ./features/productivity
    ./features/social
    ./features/virtualization
  ];

  conkyConfig = {
    enable = true;
    cpuTemp = ''''${hwmon coretemp temp 1}'';
    gpuModel = ''''${nvidia modelname 0}'';
    gpuFreq = ''''${nvidia gpufreq 0}'';
    gpuMemFreq = ''''${nvidia memfreq 0}'';
    gpuTemp = ''''${nvidia gputemp 0}'';
    ioTemp = ''''${hwmon nvme temp 1}'';
    networkWirelessDevice = "wlp0s20f3";
  };
}
