{
  description = "Nixos and home-manager shared config";
  
  nixConfig = {
      substituters = [
        "https://datantho-nixos.cachix.org"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "datantho-nixos.cachix.org-1:e1Wvy2MQcqrTm5Vedsat55IrNNZRqYvJppfbjMECXOE="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }:
    let
      system = "x86_64-linux";

      # function to create a nixos configuration with home-manager
      mkNixosHost = {
        name, # represent the name of the system
        user ? "anthony", # name of the main user
        home-manager-directory # name of directory containing the desired home.nix
      }: nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos-configs/${name}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.sharedModules = [ nixvim.homeManagerModules.nixvim ];
            home-manager.users.${user} = import ./home-manager/${home-manager-directory}/home.nix;
            nix.settings.trusted-users = [ "root" ];
          }
        ];
      };

      # create only home-manager config
      mkHMOnly = name: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = [ ./home-manager/${name}/home.nix       
          nixvim.homeManagerModules.nixvim];
      };
    in {
      nixosConfigurations = {
        zeno = mkNixosHost {
          name = "zeno";
          home-manager-directory = "anthony";
        };
	aurele = mkNixosHost {
	  name = "aurele";
	  home-manager-directory = "aurele";
	};
      };

      homeConfigurations = {
        mark = mkHMOnly "mark";
	revan = mkHMOnly "revan";
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
} 
