{ pkgs, ...}:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        dpi-aware = "yes";
        font = "FiraCode Nerd Font:size=8";
        term = "xterm-256color";
      };
    };
  };
}
