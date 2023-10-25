{ pkgs, ... }:

{
  home.packages = with pkgs; [  
    keepassxc
  ];

  home.file.keepassxc = {
    target = ".config/autostart/" + "org.keepassxc.KeePassXC" + ".desktop";
    source = (pkgs.keepassxc + "/share/applications/" + "org.keepassxc.KeePassXC" + ".desktop");
  };
}
