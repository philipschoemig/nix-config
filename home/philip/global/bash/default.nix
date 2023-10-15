{ ... }:

{
  programs.bash = {
    enable = true;

    shellAliases = {
      nrn = "nix repl --file '<nixpkgs>'";
      duh = "du -hs $(ls -A) | sort -hr";
    };
  };
}
