{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;
      withPython3 = false;
      withRuby = false;
    };
  
    nix-ld.enable = true;
  };
}
