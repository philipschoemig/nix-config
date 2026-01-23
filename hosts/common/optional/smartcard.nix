{ pkgs, ... }:

{
  services.pcscd = {
    enable = true;

    plugins = with pkgs; [
      ccid
      pcsc-cyberjack
    ];
  };

  environment.systemPackages = with pkgs; [
    pcsc-tools
  ];
}
