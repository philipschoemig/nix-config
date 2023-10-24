{ pkgs, config, ... }:
let ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.philip = {
    isNormalUser = true;
    description = "Philip Schömig";
    extraGroups = [
      "audio"
      "networkmanager"
      "video"
      "wheel"
    ] ++ ifTheyExist [
      "docker"
      "libvirtd"
      "podman"
      "wireshark"
    ];

    packages = [ pkgs.home-manager ];
  };

  home-manager.users.philip = import ../../../../home/philip/${config.networking.hostName}.nix;
}
