{ inputs, outputs, ... }:
{
  imports = [
    ./global
    ./features/desktop/xfce
    ./features/accounts/posteo.nix
  ];
}
