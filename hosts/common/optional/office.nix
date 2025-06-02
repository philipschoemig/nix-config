{ pkgs, ... }:

{
  # Workaround for onlyoffice to locate font files according to https://nixos.wiki/wiki/Onlyoffice
  fonts.packages = with pkgs; [
    corefonts
  ];

  environment.systemPackages = with pkgs; [
    onlyoffice-bin
    libreoffice
    hunspell
    hunspellDicts.de_DE
    hunspellDicts.en_US
  ];
}
