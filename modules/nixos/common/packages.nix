{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    tmux
    tree
    curl
    git
    vim
    wget
    stow
    fastfetch
    dnsutils
    pciutils
  ];
}
