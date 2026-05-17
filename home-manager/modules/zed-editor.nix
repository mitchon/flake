{ self, ... }:
{
  programs.zed-editor = {
    enable = true;
  };

  xdg.configFile."zed" = {
    source = self + /dotfiles/zed/.config/zed;
    recursive = true;
  };
}
