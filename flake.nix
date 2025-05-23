{
  description = "Nixos and home-manager shared config";
  
  nixConfig = {
      substituters = [
        "https://datantho-nixos.cachix.org"
        "https://cache.nixos.org?priority"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "datantho-nixos.cachix.org-1:7mXkZZm1vhW5N0xNuMaYQh/lipZKopDEHXKpcsiDWt8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
        name,
        user
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
            home-manager.users.${user} = import ./home-manager/${user}/home.nix;
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
          user = "anthony";
        };
      };

      homeConfigurations = {
        vps-main = mkHMOnly "mark"; 
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
} 
