{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = [
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
