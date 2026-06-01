{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    v2rayn
    sing-box
  ];
}
