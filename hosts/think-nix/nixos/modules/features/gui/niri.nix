{ pkgs, ... }:
{
  programs.niri.enable = true;
  
  services.libinput.enable = true;
  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    libnotify
    # xdg-desktop-portal-gnome
    alacritty
    xwayland-satellite
    nautilus
  ];
}
