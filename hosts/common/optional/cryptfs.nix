{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gocryptfs
    keyutils
    vaults
  ];
}
