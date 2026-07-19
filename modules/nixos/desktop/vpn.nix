{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sing-box
    v2rayn
  ];

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
}
