{ pkgs, lib, ... }:

{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
  };

  programs.bash.bashrcExtra = ''
    if [[ $TERM == "alacritty" ]]; then
      ZELLIJ_AUTO_EXIT="true"
      eval "$(${lib.getExe pkgs.zellij} setup --generate-auto-start bash)"
      eval "$(${lib.getExe pkgs.zellij} setup --generate-completion bash)"
    fi
  '';

  programs.fish.interactiveShellInit = ''
    if test "$TERM" = alacritty
      set ZELLIJ_AUTO_EXIT true
      eval (${lib.getExe pkgs.zellij} setup --generate-auto-start fish | string collect)
      eval (${lib.getExe pkgs.zellij} setup --generate-completion fish | string collect)
    end
  '';
}
