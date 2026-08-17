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

  programs = {
    neovim = {
      enable = true;
      withPython3 = false;
      withRuby = false;
    };
  };
}
