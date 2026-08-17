{
  inputs,
  pkgs,
  ...
}:

let
  sf-pro = inputs.sf-pro.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  fonts.packages = with pkgs; [
    inter
    nerd-fonts.fira-code
    noto-fonts
    sf-pro
  ];
}
