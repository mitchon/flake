{ pkgs, inputs, ... }: let
  sf-pro = inputs.sf-pro.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  fonts.packages = with pkgs; [
    noto-fonts
    nerd-fonts.fira-code
    inter
    sf-pro
  ];
}
