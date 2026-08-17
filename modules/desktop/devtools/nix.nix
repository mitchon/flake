{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nil
    nixd
  ];

  programs = {
    nix-ld.enable = true;
  };
}
