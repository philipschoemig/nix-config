{
  imports = [
    ./global
    ./features/desktop/common/firefox.nix
    ./features/development
  ];

  conkyConfig = {
    enable = true;
    cpuTemp = ''n/a'';
    gpuModel = ''n/a'';
    gpuFreq = ''n/a'';
    gpuMemFreq = ''n/a'';
    gpuTemp = ''n/a'';
    ioTemp = ''n/a'';
    networkWiredDevice = "eth0";
  };
}
