{ pkgs, ... }:
{
  programs.niri.enable = true;
  
  services.libinput.enable = true;
  services.dbus.enable = true;
  #for nautilus
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    libnotify
    # xdg-desktop-portal-gnome
    xwayland-satellite
    nautilus
    file-roller
    libheif
    libheif.out
  ];

  environment.pathsToLink = [ "share/thumbnailers" ];
}
