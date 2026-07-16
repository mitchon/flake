{ pkgs, inputs, ... }:
{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];
  
  environment.systemPackages = [
    # pkgs.polkit_gnome
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.noctalia-greeter = {
    enable = true;
    package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

    settings = {
      cursor = {
        theme = "Adwaita";
        size = 24;
        package = pkgs.adwaita-icon-theme;
      };
    };
  };

  # security.polkit.enable = true;
}
