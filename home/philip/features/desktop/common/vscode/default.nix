{pkgs, ...}: {
  home.packages = with pkgs; [
    clang-tools # CLI tools for C++ development, required by extension llvm-vs-code-extensions.vscode-clangd
    nil # Nix language server, required for extension jnoortheen.nix-ide
  ];

  programs.vscode = {
    enable = true;

    # Use VSCodium instead of VSCode.
    package = pkgs.vscodium;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = true;

    extensions = with pkgs.vscode-extensions;
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
          version = "2.2.2";
          sha256 = "jW2bf1Njp1n67khT1+L2pxFBB+F2bTaAuofz2AqDPO4=";
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

    # TODO how to use this properly?
    # VSCode annoys with messages that the settings could not be saved
    # as soon as a small things change when using this software.
    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
  };
}
