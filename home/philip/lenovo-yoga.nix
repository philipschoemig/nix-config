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
    # gpuModel = ''''${nvidia modelname 0}'';
    gpuModel = ''''${execi 86400 nvidia-smi --query-gpu=name --format=csv,noheader}'';
    # gpuFreq = ''''${nvidia gpufreq 0}'';
    gpuFreq = ''''${exec nvidia-smi --query-gpu=clocks.gr --format=csv,noheader | cut -d' ' -f1}'';
    # gpuMemFreq = ''''${nvidia memfreq 0}'';
    gpuMemFreq = ''''${exec nvidia-smi --query-gpu=clocks.mem --format=csv,noheader | cut -d' ' -f1}'';
    # gpuTemp = ''''${nvidia gputemp 0}'';
    gpuTemp = ''''${exec nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader}'';
    ioTemp = ''''${hwmon nvme temp 1}'';
    networkWirelessDevice = "wlp0s20f3";
  };
}
