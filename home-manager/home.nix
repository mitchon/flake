{ config, user, stateVersion, pkgs, ... }: {
  imports = [
    # inputs.nix-colors.homeManagerModule
    # ./nvim.nix
    ./modules
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = stateVersion;
  };

  programs.neovim = {
    enable = true;
    withPython3 = false;
    withRuby = false;
  };
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
  
  home.packages = with pkgs; [
    fastfetch
    telegram-desktop
    nil
    nixd
    ansible
    jetbrains.idea
    lazygit
    lazydocker
    lazysql
    qbittorrent
    opentofu
    terraform-ls
  ];

  xdg.dataFile = {
    "v2rayN/bin/sing_box/sing-box" = {
      source = "${pkgs.sing-box}/bin/sing-box";
      force = true;
    };
    "v2rayN/bin/xray/xray" = {
      source = "${pkgs.xray}/bin/xray";
      force = true;
    };
  };
    
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
