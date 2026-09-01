{ pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./gaming.nix
    ./i2c.nix
    ./niri.nix
    ./noctalia.nix
    ./ssh-askpass.nix
    ./utils.nix
  ];

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1 = 80; 
    };
  };
  services.upower.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    cliphist
    ddcutil
    playerctl
    wl-clipboard
    udiskie
    libsixel
  ];
}
