{
  programs.fish = {
    enable = true;

    functions = {
      duh = "du -ahd 1 $argv | sort -hr";
    };

    shellAliases = {
      nrn = "nix repl --file '<nixpkgs>'";
    };
  };
}
