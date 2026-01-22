{
  imports = [
    ./global
    ./features/accounts/posteo.nix
    ./features/development
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
      # gpuModel = "\${nvidia modelname 0}";
      gpuModel = "\${execi 86400 ${nvidiaSmi} --query-gpu=name --format=csv,noheader}";
      # gpuFreq = "\${nvidia gpufreq 0}";
      gpuCoreFreq = "\${exec ${nvidiaSmi} --query-gpu=clocks.gr --format=csv,noheader | cut -d' ' -f1}";
      # gpuUsage = "\${nvidia gpuutil 0}";
      # gpuMemFreq = "\${nvidia memfreq 0}";
      gpuMemFreq = "\${exec ${nvidiaSmi} --query-gpu=clocks.mem --format=csv,noheader | cut -d' ' -f1}";
      # gpuMemUsed = "\${nvidia memused 0}";
      # gpuMemTotal = "\${nvidia memtotal 0}";
      # gpuMemUsage = "\${nvidia memutil 0}";
      # gpuTemp = "\${nvidia gputemp 0}";
      gpuTemp = "\${exec ${nvidiaSmi} --query-gpu=temperature.gpu --format=csv,noheader}";
      networkWirelessDevice = "wlp0s20f3";
    };
}
