{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      # url = "github:notiant/noctalia-shell/patch-1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    self.submodules = true;
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      stateVersion = "25.11";
      user = "mitchanx";
      hostname = "think-nix";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit inputs stateVersion hostname user; };
        modules = [
          ./nixos/configuration.nix
          ./noctalia.nix
        ];
      };

      homeConfigurations."${user}@${hostname}" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs self stateVersion hostname user; };
        modules = [ ./home-manager/home.nix ];
      };

      devShells.${system}.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          corretto21
          gradle
          maven
          jetbrains.idea

          telepresence
          k9s

          postman
        ];
      
        shellHook = ''
          export JAVA_HOME=${pkgs.corretto21}
        '';
      };
    };
}
