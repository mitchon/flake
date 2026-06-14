{ inputs, user, stateVersion, pkgs, ... }: {
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
    eog
    libsixel

    talosctl
    kubectl
    k9s
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
    
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
