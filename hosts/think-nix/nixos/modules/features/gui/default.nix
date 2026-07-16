{ pkgs, ... }:
{
  imports = [
    ./niri.nix
    ./fonts.nix
    # ./greeter.nix
    ./noctalia.nix
    ./i2c.nix
    ./ssh-askpass.nix
    ./gaming.nix
  ];

  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];
  
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.udisks2.enable = true;
  
  environment.systemPackages = with pkgs; [
    wl-clipboard
    cliphist
    brightnessctl
    playerctl
    ddcutil
  ];
}
