{ lib, ... }:

{
  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = {
      user = {
        name = "Philip Schömig";
        email = lib.mkDefault "philip.schoemig@posteo.de";
      };
      core.quotepath = "off";
      init.defaultBranch = "main";
      pull.ff = "only";
    };
  };
}
