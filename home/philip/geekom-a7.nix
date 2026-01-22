{ options, pkgs, ... }:

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

  conkyConfig = {
    enable = true;
    packages = options.conkyConfig.packages.default ++ [
      pkgs.gnugrep
      pkgs.nvtopPackages.amd
    ];
    cpuModel = "\${execi 86400 sed -n 's/([^)]*)//g; /model name/ {s/.*: //; s/ CPU.*//; s/ w[/] Radeon.*//; p; q}' /proc/cpuinfo}";
    cpuTemp = "\${hwmon k10temp temp 1}";
    gpuModel = ''''${execi 86400 nvtop -s | jq -r '.[0].device_name // "N/A"'}'';
    gpuCoreFreq = ''''${exec grep -Po '\d+:\s\K(\d+)(?=.*\*$)' /sys/class/drm/card*/device/pp_dpm_sclk | head -1}'';
    gpuMemFreq = ''''${exec grep -Po '\d+:\s\K(\d+)(?=.*\*$)' /sys/class/drm/card*/device/pp_dpm_mclk | head -1}'';
    gpuMemUsed = "\${exec cat /sys/class/drm/card*/device/mem_info_vram_used | head -1 | numfmt --to=iec-i --suffix=B}";
    gpuMemTotal = "\${exec cat /sys/class/drm/card*/device/mem_info_vram_total | head -1 | numfmt --to=iec-i --suffix=B}";
    gpuMemUsage = ''''${exec nvtop -s | jq -r '.[0].mem_util // "N/A" | rtrimstr("%")'}'';
    gpuTemp = "\${hwmon amdgpu temp 1}";
    gpuUsage = ''''${exec nvtop -s | jq -r '.[0].gpu_util // "N/A" | rtrimstr("%")'}'';
    networkWiredDevice = "enp1s0";
    networkWirelessDevice = "wlp2s0";
  };
}
