{ pkgs, ... }:

{
  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # batch processing/automation
    jq # sed for json

    # compression tools
    p7zip

    # development tools
    git
    git-crypt # used to store secrets in configuration
    git-lfs # used to store large files

    # file editors
    neovim

    # file tools
    dos2unix # convert CRLF (dos) or CR (classic mac) line endings to LF (unix)
    file # file type
    rclone # syncs files from cloud storage

    # hardware tools
    dmidecode # hardware information
    hdparm # hard drive management
    lm_sensors # temperature sensors
    parted # partition manager
    pciutils # lspci
    smartmontools # hard drive monitoring
    tcpdump # package inspector
    usbutils # lsusb

    # network tools
    dnsutils # dig
    nmap # port scanner
    wget # download tool

    # system tools
    powertop

    # terminal tools
    tmux

    # text processing tools
    ripgrep

    # top like tools
    htop
  ];
}
