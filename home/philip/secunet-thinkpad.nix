{ options, pkgs, ... }:

{
  imports = [
    ./global
    ./features/desktop/xfce
    ./features/development
  ];

  programs.git.settings.user.email = "philip.schoemig@secunet.com";

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "git.seven.secucloud.secunet.com" = {
        IdentityFile = "~/.ssh/id_ed25519";
        IdentitiesOnly = true;
      };
      "gwp" = {
        Hostname = "10.100.0.2";
        User = "root";
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
      "gwp-edge" = {
        User = "root";
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
      "gwp-juno" = {
        User = "root";
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
      "test_client" = {
        Hostname = "localhost";
        Port = 2221;
        User = "root";
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
      "test_router" = {
        Hostname = "localhost";
        Port = 2222;
        User = "root";
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
      "test_server" = {
        Hostname = "localhost";
        Port = 2223;
        User = "root";
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
      };
    };
  };

  conkyConfig = {
    enable = true;
    packages = options.conkyConfig.packages.default ++ [
      pkgs.gawk
      pkgs.pciutils
    ];
    gpuModel = ''''${exec lspci -mm | awk -F '\"|\" \"|\\(' '/"Display|"3D|"VGA/ {print $3 " " $4}'}'';
    gpuCoreFreq = "\${exec cat /sys/class/drm/card*/gt_cur_freq_mhz | head -1}";
    ioTemp = "\${hwmon nvme temp 1}";
    networkWiredDevice = "enp0s31f6";
    networkWirelessDevice = "wlp0s20f3";
  };
}
