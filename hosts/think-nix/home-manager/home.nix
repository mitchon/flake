{
  inputs,
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./modules
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
    sessionVariables = {
      JAVA_HOME = pkgs.corretto21;
    };
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

    corretto21
    gradle
    maven

    telepresence2
    postman

    libreoffice
    hunspellDicts.en-gb-ise
    hunspellDicts.en-us
    hunspellDicts.ru-ru
    zoom-us
    codex

    chromium
    figma-linux

    nicotine-plus
    nocturne
    vlc

    nodejs_22
  ];
}
