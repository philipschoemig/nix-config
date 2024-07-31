{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.users.philip = {
    isNormalUser = true;
    description = "Philip Schömig";
    extraGroups =
      [
        "audio"
        "dialout"
        "lp"
        "networkmanager"
        "plugdev"
        "video"
        "wheel"
      ]
      ++ ifTheyExist [
        "adbusers"
        "docker"
        "libvirtd"
        "podman"
        "scanner"
        "wireshark"
      ];

    packages = [pkgs.home-manager];
  };

  home-manager.users.philip = import ../../../../home/philip/${config.networking.hostName}.nix;
}
