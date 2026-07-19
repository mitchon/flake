{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sf-pro = {
      url = "github:mitchon/sf-pro-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      disko,
      home-manager,
      ...
    }:
    let
      defaultSystem = "x86_64-linux";
      defaultUser = "mitchanx";

      mkSystem =
        {
          hostname,
          modules,
          system ? defaultSystem,
          user ? defaultUser,
        }:
        nixpkgs.lib.nixosSystem {
          inherit system modules;
          specialArgs = { inherit inputs hostname user; };
        };

      bootstrap = mkSystem {
        hostname = "nixos-bootstrap";
        modules = [ ./images/bootstrap.nix ];
      };
    in
    {
      nixosConfigurations = {
        think-nix = mkSystem {
          hostname = "think-nix";
          modules = [
            ./hosts/think-nix/nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs;
                  user = defaultUser;
                };
                users.${defaultUser} = import ./hosts/think-nix/home-manager/home.nix;
              };
            }
          ];
        };

        homelab = mkSystem {
          hostname = "homelab";
          modules = [
            disko.nixosModules.disko
            ./hosts/homelab/default.nix
          ];
        };

        nixos-bootstrap = bootstrap;
      };

      homeConfigurations."${defaultUser}@think-nix" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = defaultSystem;
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit inputs;
          user = defaultUser;
        };
        modules = [ ./hosts/think-nix/home-manager/home.nix ];
      };

      packages.${defaultSystem} = {
        iso = bootstrap.config.system.build.isoImage;
        default = self.packages.${defaultSystem}.iso;
      };

      formatter.${defaultSystem} = nixpkgs.legacyPackages.${defaultSystem}.nixfmt;
    };
}
