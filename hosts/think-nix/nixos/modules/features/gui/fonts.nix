{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    noto-fonts
    nerd-fonts.fira-code
  ];
}
