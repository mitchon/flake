{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    dnsutils
    pciutils
  ];
}
