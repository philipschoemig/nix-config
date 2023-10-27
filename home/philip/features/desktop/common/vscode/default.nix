{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    # Use VSCodium instead of VSCode.
    package = pkgs.vscodium;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = true;

    extensions = with pkgs.vscode-extensions; [
      arrterian.nix-env-selector
      bierner.markdown-mermaid
      bungcip.better-toml
      davidanson.vscode-markdownlint
      eamodio.gitlens
      esbenp.prettier-vscode
      foxundermoon.shell-format
      gruntfuggly.todo-tree
      jebbs.plantuml
      jnoortheen.nix-ide
      matklad.rust-analyzer
      mkhl.direnv
      ms-azuretools.vscode-docker
      ms-python.python
      ms-vscode.cpptools
      ms-vsliveshare.vsliveshare
      njpwerner.autodocstring
      redhat.vscode-yaml
      streetsidesoftware.code-spell-checker
      timonwong.shellcheck
      vadimcn.vscode-lldb
      valentjn.vscode-ltex
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # VS Code extensions that are not part of pkgs.vscode-extensions.
      {
        name = "code-spell-checker-german";
        publisher = "streetsidesoftware";
        version = "2.2.2";
        sha256 = "jW2bf1Njp1n67khT1+L2pxFBB+F2bTaAuofz2AqDPO4=";
      }
      {
        name = "commitlint";
        publisher = "joshbolduc";
        version = "2.4.7";
        sha256 = "cVJZbMPtqo6BnU3DC8/XQwVEUbH8xKrwm/J6y5rKVf4=";
      }
      {
        name = "live-server";
        publisher = "ms-vscode";
        version = "0.4.8";
        sha256 = "/IrLq+nNxwQB1S1NIGYkv24DOY7Mc25eQ+orUfh42pg=";
      }
      {
        name = "vscode-coverage-gutters";
        publisher = "ryanluker";
        version = "2.11.0";
        sha256 = "laffIVS06BBQYZhhSP0BJiPhz0tZ2DKhJbVT95vYKOc=";
      }
    ];

    keybindings = builtins.fromJSON (builtins.readFile ./keybindings.json);

    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);

    # TODO how to use this properly?
    # VSCode annoys with messages that the settings could not be saved
    # as soon as a small things change when using this software.
    # userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
  };
}
