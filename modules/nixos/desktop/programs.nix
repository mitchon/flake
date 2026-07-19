{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dnsutils
    pciutils
  ];

  programs.nix-ld.enable = true;
}
