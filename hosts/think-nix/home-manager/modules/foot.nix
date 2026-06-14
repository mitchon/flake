{ config, ...}:
{
  programs.foot = {
    enable = true;
  };

  xdg.configFile."foot" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/foot/.config/foot";
    recursive = true;
  };
}
