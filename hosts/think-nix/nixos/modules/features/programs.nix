{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    dnsutils
    pciutils
  ];

  programs.nix-ld.enable = true;
}
