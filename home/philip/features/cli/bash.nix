{
  programs.bash = {
    enable = true;

    shellAliases = {
      nrn = "nix repl --file '<nixpkgs>'";
      duh = "du -ahd 1 | sort -hr";
    };
  };
}
