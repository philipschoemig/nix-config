{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib // home-manager.lib;
    systems = ["x86_64-linux"];
    forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
  in {
    inherit lib;

    overlays = import ./overlays {inherit inputs outputs;};

    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

    nixosConfigurations = {
      # Personal laptop
      "lenovo-yoga" = lib.nixosSystem {
        modules = [
          ./hosts/lenovo-yoga
        ];
        specialArgs = {inherit inputs outputs;};
      };
      # Work laptop
      "secunet-thinkpad" = lib.nixosSystem {
        modules = [
          ./hosts/secunet-thinkpad
        ];
        specialArgs = {inherit inputs outputs;};
      };
    };

    homeConfigurations = {
      "philip@lenovo-yoga" = lib.homeManagerConfiguration {
        modules = [./home/philip/lenovo-yoga.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
      "philip@secunet-thinkpad" = lib.homeManagerConfiguration {
        modules = [./home/philip/secunet-thinkpad.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
      };
    };
  };
}
