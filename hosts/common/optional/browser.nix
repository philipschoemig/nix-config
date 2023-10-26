{
  programs.chromium = {
    enable = true;

    defaultSearchProviderEnabled = true;
    defaultSearchProviderSearchURL = "https://search.demoniak.ch/search?q=%s";
    defaultSearchProviderSuggestURL = "https://search.demoniak.ch/search?q=%s";

    extraOpts = {
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
                               "de"
                               "en-US"
                             ];
    };
  };

  programs.firefox = {
    enable = true;

    languagePacks = [
      "de"
      "en-US"
    ];

    policies = {
      "OfferToSaveLogins" = false;
      "OfferToSaveLoginsDefault" = false;
      "PasswordManagerEnabled" = false;
    };
  };
}
