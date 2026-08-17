{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.noctalia.nixosModules.default
    inputs.noctalia-greeter.nixosModules.default
  ];

  programs = {
    noctalia = {
      enable = true;
      recommendedServices.enable = true;
      systemd.enable = true;
    };
    noctalia-greeter = {
      enable = true;
      package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
      settings.cursor = {
        theme = "Adwaita";
        size = 24;
        package = pkgs.adwaita-icon-theme;
      };
    };
  };
}
