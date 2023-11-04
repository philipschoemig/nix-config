let
  user = "philip.schoemig";
  host = "posteo.de";
  address = "${user}@${host}";
in {
  accounts = {
    # calendar.accounts = {
    #   "${address}" = {
    #     primary = true;
    #     remote = {
    #       type = "caldav";
    #       url = "https://${host}:8443/calendars/${user}/default";
    #       userName = address;
    #     };
    #   };
    # };
    # contacts.accounts = {
    #   "${address}" = {
    #     primary = true;
    #     remote = {
    #       type = "carddav";
    #       url = "https://${host}:8843/addressbooks/${user}/default";
    #       userName = address;
    #     };
    #   };
    # };
    email.accounts = {
      "${address}" = {
        inherit address;
        imap = {
          inherit host;
          port = 993;
        };
        primary = true;
        realName = "Philip Schömig";
        smtp = {
          inherit host;
          port = 465;
        };
        thunderbird = {
          enable = true;
          settings = id: {
            "mail.server.server_${id}.autosync_max_age_days" = 30;
            "mail.server.server_${id}.limit_offline_message_size" = true;
            "mail.server.server_${id}.max_size" = 50;
          };
        };
        userName = address;
      };
    };
  };
}
