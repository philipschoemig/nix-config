{ pkgs, ... }:

{
  imports = [
    ../java.nix # Required for SonarSource.sonarlint-vscode
  ];

  home.packages = with pkgs; [
    clang-tools # CLI tools for C++ development, required by extension llvm-vs-code-extensions.vscode-clangd
    nil # Nix language server, required for extension jnoortheen.nix-ide
    sonarlint-ls # Sonarlint language server, required for SonarSource.sonarlint-vscode
  ];

  programs.vscode = {
    enable = true;

    # Use VSCodium instead of VSCode.
    package = pkgs.vscodium;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = true;

    extensions =
      with pkgs.vscode-extensions;
      [
        arrterian.nix-env-selector
        bierner.markdown-mermaid
        davidanson.vscode-markdownlint
        eamodio.gitlens
        esbenp.prettier-vscode
        foxundermoon.shell-format
        gruntfuggly.todo-tree
        jebbs.plantuml
        jnoortheen.nix-ide
        llvm-vs-code-extensions.vscode-clangd
        mkhl.direnv
        ms-azuretools.vscode-docker
        ms-python.python
        ms-vscode.cpptools-extension-pack
        ms-vsliveshare.vsliveshare
        njpwerner.autodocstring
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        streetsidesoftware.code-spell-checker
        tamasfe.even-better-toml
        timonwong.shellcheck
        vadimcn.vscode-lldb
        valentjn.vscode-ltex
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # VS Code extensions that are not part of pkgs.vscode-extensions.
        {
          name = "code-spell-checker-german";
          publisher = "streetsidesoftware";
          version = "2.3.3";
          sha256 = "sEdr8SQDFWgCq77flvbReILgWtT/ao8cJjrgC7RKO80=";
        }
        {
          name = "live-server";
          publisher = "ms-vscode";
          version = "0.5.2024091601";
          sha256 = "cwntFW5McTAcFs0f+vTlLpZffz3ApYGxu0ctJ2X6EuY=";
        }
        {
          name = "sonarlint-vscode";
          publisher = "SonarSource";
          version = "4.21.0";
          sha256 = "pnxHROhjbQq93CeWkBU3KwIPeXVDA4K6ifkkoGfagIM=";
        }
        {
          name = "vscode-coverage-gutters";
          publisher = "ryanluker";
          version = "2.13.0";
          sha256 = "qgPKGikqNIeZkKfd0P0keAdxRl9XNzvEJKQy58eaUZk=";
        }
      ];

    keybindings = builtins.fromJSON (builtins.readFile ./keybindings.json);

    # TODO how to use this properly?
    # VSCode annoys with messages that the settings could not be saved
    # as soon as a small things change when using this software.
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
  };
}
