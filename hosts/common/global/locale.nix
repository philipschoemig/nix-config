{ lib, ... }:

let
  englishLocale = "en_US.UTF-8";
  germanLocale = "de_DE.UTF-8";
in
{
  i18n = {
    defaultLocale = lib.mkDefault englishLocale;

    extraLocaleSettings = {
      LC_ADDRESS = lib.mkDefault germanLocale;
      LC_IDENTIFICATION = lib.mkDefault germanLocale;
      LC_MEASUREMENT = lib.mkDefault germanLocale;
      LC_MONETARY = lib.mkDefault germanLocale;
      LC_NAME = lib.mkDefault germanLocale;
      LC_NUMERIC = lib.mkDefault germanLocale;
      LC_PAPER = lib.mkDefault germanLocale;
      LC_TELEPHONE = lib.mkDefault germanLocale;
      LC_TIME = lib.mkDefault germanLocale;
    };

    supportedLocales = lib.mkDefault [
      "${englishLocale}/UTF-8"
      "${germanLocale}/UTF-8"
    ];
  };

  console.keyMap = lib.mkDefault "de";

  time.timeZone = lib.mkDefault "Europe/Berlin";
}
