{ pkgs, ... }:

{
  imports = [
    ../java.nix # Required for SonarSource.sonarlint-vscode
    ../nodejs.nix # Required for SonarSource.sonarlint-vscode
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

    profiles."default" = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = true;

      extensions =
        with pkgs.vscode-extensions;
        [
          arrterian.nix-env-selector
          bierner.markdown-mermaid
          charliermarsh.ruff
          davidanson.vscode-markdownlint
          eamodio.gitlens
          esbenp.prettier-vscode
          foxundermoon.shell-format
          gruntfuggly.todo-tree
          jebbs.plantuml
          jnoortheen.nix-ide
          llvm-vs-code-extensions.vscode-clangd
          mkhl.direnv
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
            name = "vscode-containers";
            publisher = "ms-azuretools";
            version = "2.3.0";
            sha256 = "zrEZpd2geX2G4u6LkIk3d6C7vhwZZ4lwHGQR3Z0OWY4=";
          }
          {
            name = "live-server";
            publisher = "ms-vscode";
            version = "0.5.2025091501";
            sha256 = "P/VY3RWEv6S2Y0czxPnPWM94C7ursF957xe1L68VYWY=";
          }
          {
            name = "vscode-coverage-gutters";
            publisher = "ryanluker";
            version = "2.14.0";
            sha256 = "waF3FmncUsXqWFWGRy9X7RQ29BDRYlaqyFhEXg4HXNo=";
          }
          {
            name = "sonarlint-vscode";
            publisher = "SonarSource";
            version = "4.35.1";
            sha256 = "GOTt/fGyyHlTkU5jBs7r/Hf6vJ2ASeU0Y9XjaLdO6q0=";
          }
          {
            name = "code-spell-checker-german";
            publisher = "streetsidesoftware";
            version = "2.3.4";
            sha256 = "zc0cv4AOswvYcC4xJOq2JEPMQ5qTj9Dad5HhxtNETEs=";
          }
        ];

      keybindings = builtins.fromJSON (builtins.readFile ./keybindings.json);

      # TODO how to use this properly?
      # VSCode annoys with messages that the settings could not be saved
      # as soon as a small things change when using this software.
      userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    };
  };

  xdg.mimeApps.defaultApplications = {
    "application/json" = "codium.desktop";
    "application/xml" = "codium.desktop";
    "text/csv" = "codium.desktop";
    "text/markdown" = "codium.desktop";
    "text/plain" = "codium.desktop";
    "text/xml" = "codium.desktop";
  };
}
