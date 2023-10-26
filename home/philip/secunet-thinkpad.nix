{ inputs, outputs, ... }:
{
  imports = [
    ./global
    ./features/desktop/xfce
  ];

  programs.git.userEmail = "philip.schoemig@secunet.com";
}
