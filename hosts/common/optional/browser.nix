{
  programs.chromium = {
    enable = true;

    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://www.startpage.com/sp/search?query=%s";
    defaultSearchProviderSuggestURL = "https://www.startpage.com/sp/search?query=%s";

    extraOpts = {
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "de"
        "en-US"
        "en-GB"
      ];
    };
  };

  programs.firefox = {
    enable = true;

    languagePacks = [
      "de"
      "en-US"
      "en-GB"
    ];

    policies = {
      "OfferToSaveLogins" = false;
      "OfferToSaveLoginsDefault" = false;
      "PasswordManagerEnabled" = false;
    };
  };
}
