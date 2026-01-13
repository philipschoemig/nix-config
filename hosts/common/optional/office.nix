{ pkgs, ... }:

{
  # Workaround for onlyoffice to locate font files according to https://wiki.nixos.org/wiki/ONLYOFFICE
  fonts.packages = with pkgs; [
    corefonts
  ];

  environment.systemPackages = with pkgs; [
    onlyoffice-desktopeditors
    libreoffice
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
  ];
}
