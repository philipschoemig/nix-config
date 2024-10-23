{pkgs, ...}:

{
  # Enable ecryptfs mount wrappers
  programs.ecryptfs.enable = true;

  environment.systemPackages = with pkgs; [
    ecryptfs
  ];
}
