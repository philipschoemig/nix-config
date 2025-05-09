{ inputs, outputs, ... }:

{
  imports = [
    ./global
    ./features/desktop/xfce
    ./features/development
  ];

  programs.git.userEmail = "philip.schoemig@secunet.com";
}
