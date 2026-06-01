{ config, ... }:
{
  programs.zed-editor = {
    enable = true;
  };

  xdg.configFile."zed" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/zed/.config/zed";
    recursive = true;
  };
}
