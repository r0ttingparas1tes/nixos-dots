{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    system = "x86_64-linux";
  in

  {
    nixosConfigurations = {
      # Desktop
      thraK = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/thraK/configuration.nix
	  ./modules/desktop
	  ./modules/dev
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      # Laptop
      fraKctured = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/fraKctured/configuration.nix
	  ./modules/desktop
	  ./modules/dev
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      # Server
      starless = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/starless/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}
