{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    exitShellOnExit = true;
  };

  programs.bash.bashrcExtra = ''
    if [[ $TERM == "alacritty" ]]; then
      eval "$(${pkgs.zellij}/bin/zellij setup --generate-auto-start bash)"
      eval "$(${pkgs.zellij}/bin/zellij setup --generate-completion bash)"
    fi
  '';

  programs.fish.interactiveShellInit = ''
    if test "$TERM" = alacritty
      eval (${pkgs.zellij}/bin/zellij setup --generate-auto-start fish | string collect)
      eval (${pkgs.zellij}/bin/zellij setup --generate-completion fish | string collect)
    end
  '';
}
