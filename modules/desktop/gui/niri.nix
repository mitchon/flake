{ pkgs, ... }:

{
  programs.niri.enable = true;

  services = {
    dbus.enable = true;
    gvfs.enable = true;
    libinput.enable = true;
    udisks2.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    file-roller
    libheif
    libheif.out
    libnotify
    nautilus
    xwayland-satellite
  ];

  environment.pathsToLink = [ "share/thumbnailers" ];
}
