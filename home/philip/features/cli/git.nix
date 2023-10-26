{ lib, ... }:

{
  programs.git = {
    enable = true;

    lfs.enable = true;

    userName = "Philip Schömig";
    userEmail = lib.mkDefault "philip.schoemig@posteo.de";

    extraConfig = {
      core.quotepath = "off";
      init.defaultBranch = "main";
      pull.ff = "only";
    };
  };
}
