{ pkgs, lib, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Philip Schömig";
    userEmail = "philip.schoemig@posteo.de";
    extraConfig = {
      init.defaultBranch = "main";
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
