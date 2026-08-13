{ pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./gaming.nix
    ./i2c.nix
    ./niri.nix
    ./noctalia.nix
    ./ssh-askpass.nix
  ];

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    cliphist
    ddcutil
    playerctl
    wl-clipboard
    udiskie
  ];
}
