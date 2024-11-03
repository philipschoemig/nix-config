{
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
{
  imports = [
    # Common CLI tools
    ../features/cli
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  fonts.fontconfig.enable = true;

  home = {
    username = lib.mkDefault "philip";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";
    sessionPath = [ "$HOME/.local/bin" ];
    sessionVariables = {
      FLAKE = "$HOME/Projects/github.com/philipschoemig/nix-config";
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/ssh-agent.socket";
    };
  };
}
