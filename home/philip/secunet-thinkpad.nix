{
  imports = [
    ./global
    ./features/desktop/xfce
    ./features/development
  ];

  programs.git.settings.user.email = "philip.schoemig@secunet.com";

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "git.seven.secucloud.secunet.com" = {
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
      "edge" = {
        hostname = "10.100.0.2";
        user = "root";
        extraOptions = {
          "StrictHostKeyChecking" = "no";
          "UserKnownHostsFile" = "/dev/null";
        };
      };
      "test_client" = {
        hostname = "localhost";
        port = 2221;
        user = "root";
        extraOptions = {
          "StrictHostKeyChecking" = "no";
          "UserKnownHostsFile" = "/dev/null";
        };
      };
      "test_router" = {
        hostname = "localhost";
        port = 2222;
        user = "root";
        extraOptions = {
          "StrictHostKeyChecking" = "no";
          "UserKnownHostsFile" = "/dev/null";
        };
      };
      "test_server" = {
        hostname = "localhost";
        port = 2223;
        user = "root";
        extraOptions = {
          "StrictHostKeyChecking" = "no";
          "UserKnownHostsFile" = "/dev/null";
        };
      };
    };
  };

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
