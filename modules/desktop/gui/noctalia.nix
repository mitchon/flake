{ pkgs, ... }:
{

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
    systemd.enable = true;
  };

  services.displayManager.noctalia-greeter = {
    enable = true;
    settings.cursor = {
      theme = "Adwaita";
      size = 24;
      package = pkgs.adwaita-icon-theme;
    };
  };
}
