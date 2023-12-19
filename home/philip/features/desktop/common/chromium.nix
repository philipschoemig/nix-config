{pkgs, ...}: {
  programs.chromium = {
    enable = true;

    dictionaries = with pkgs.hunspellDictsChromium; [
      en_US
      en_GB
      de_DE
    ];

    extensions = [
      "mlomiejdfkolichcflejclcbmpeaniij" # Ghostery – Privacy Ad Blocker
      "oboonakemofpalcgghocfoadofidjkkk" # KeePassXC-Browser
      "blaaajhemilngeeffpbfkdjjoefldkok" # LeechBlock NG
    ];
  };
}
