{
  description = "My NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
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
	  home-manager.nixosModules.home-manager
	  {
	    home-manager = {
	      useGlobalPkgs = true;
	      useUserPackages = true;
	      extraSpecialArgs = { inherit inputs; };
	      users.jazz = ./hosts/fraKctured/home; # it has a default.nix
	      backupFileExtension = "backup";
	    };
	  }
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
