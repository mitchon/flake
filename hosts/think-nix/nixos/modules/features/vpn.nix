{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    v2rayn
    sing-box
  ];

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
}
