{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
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
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = { inherit inputs stateVersion hostname user; };
        modules = [
          ./hosts/${hostname}/nixos/configuration.nix
        ];
      };

      homeConfigurations."${user}@${hostname}" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs self stateVersion hostname user; };
        modules = [ ./hosts/${hostname}/home-manager/home.nix ];
      };

      # devShells.${system}.default = pkgs.mkShell {
      #   nativeBuildInputs = with pkgs; [
      #     corretto21
      #     gradle
      #     maven
      #     jetbrains.idea

      #     telepresence
      #     k9s

      #     postman
      #   ];
      
      #   shellHook = ''
      #     export JAVA_HOME=${pkgs.corretto21}
      #   '';
      # };
    };
}
