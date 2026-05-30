{ self, pkgs, ... }:
{
  home.packages = with pkgs; [
    opentofu
    terraform-ls
    tofu-ls
  ];

  home.file.".tofurc" = {
    source = self + /dotfiles/opentofu/.tofurc;
    recursive = true;
  };
}
