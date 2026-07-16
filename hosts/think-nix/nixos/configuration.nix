{ stateVersion, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; 

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  system.stateVersion = stateVersion;
}
