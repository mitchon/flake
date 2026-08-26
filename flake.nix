{
  nixConfig = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };
  
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
      # inputs.nixpkgs.follows = "nixpkgs";
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
    chatgpt = {
      url = "github:ilysenko/codex-desktop-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, disko, ... }: 
    let
      defaultSystem = "x86_64-linux";
      defaultUser = "mitchanx";
  
      mkSystem = 
      { hostname, modules, system ? defaultSystem, user ? defaultUser }:
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
            ./hosts/think-nix/configuration.nix
          ];
        };

        homelab = mkSystem {
          hostname = "homelab";
          modules = [
            disko.nixosModules.disko
            ./hosts/homelab/configuration.nix
          ];
        };

        nixos-bootstrap = bootstrap;
      };

      packages.${defaultSystem} = {
        iso = bootstrap.config.system.build.isoImage;
        default = self.packages.${defaultSystem}.iso;
      };

      formatter.${defaultSystem} = nixpkgs.legacyPackages.${defaultSystem}.nixfmt;
    };
}
