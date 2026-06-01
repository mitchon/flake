{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    opentofu
    terraform-ls
    tofu-ls
  ];

  home.file.".tofurc" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/opentofu/.tofurc";
    recursive = true;
  };
}
