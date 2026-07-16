{ pkgs, ... }: {
  home.packages = with pkgs; [
    pinniped
  ];
}
