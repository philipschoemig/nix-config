{ inputs, lib, ... }:
{
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    };

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   # Keep the last 3 generations
    #   options = "--delete-older-than +3";
    # };
  };
}
