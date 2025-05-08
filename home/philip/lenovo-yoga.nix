{
  imports = [
    ./global
    ./features/accounts/posteo.nix
    ./features/desktop/xfce
    ./features/productivity
    ./features/social
    ./features/virtualization
  ];

  conkyConfig =
    let
      nvidiaSmi = "/run/current-system/sw/bin/nvidia-smi";
    in
    {
      enable = true;
      cpuTemp = ''''${hwmon coretemp temp 1}'';
      # gpuModel = ''''${nvidia modelname 0}'';
      gpuModel = ''''${execi 86400 ${nvidiaSmi} --query-gpu=name --format=csv,noheader}'';
      # gpuFreq = ''''${nvidia gpufreq 0}'';
      gpuFreq = ''''${exec ${nvidiaSmi} --query-gpu=clocks.gr --format=csv,noheader | cut -d' ' -f1}'';
      # gpuMemFreq = ''''${nvidia memfreq 0}'';
      gpuMemFreq = ''''${exec ${nvidiaSmi} --query-gpu=clocks.mem --format=csv,noheader | cut -d' ' -f1}'';
      # gpuTemp = ''''${nvidia gputemp 0}'';
      gpuTemp = ''''${exec ${nvidiaSmi} --query-gpu=temperature.gpu --format=csv,noheader}'';
      ioTemp = ''''${hwmon nvme temp 1}'';
      networkWirelessDevice = "wlp0s20f3";
    };
}
