{ ... }:

{
  imports = [
    ../../../profiles/workstation.nix
    ./boot.nix
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
