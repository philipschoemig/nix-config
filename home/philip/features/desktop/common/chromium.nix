{pkgs, ...}: {
  programs.chromium = {
    enable = true;

    extensions = [
      "mlomiejdfkolichcflejclcbmpeaniij" # Ghostery – Privacy Ad Blocker
      "oboonakemofpalcgghocfoadofidjkkk" # KeePassXC-Browser
      "blaaajhemilngeeffpbfkdjjoefldkok" # LeechBlock NG
    ];
  };
}
