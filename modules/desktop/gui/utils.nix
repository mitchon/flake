{ pkgs, inputs, ... }:
{
  programs.foot = {
    enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    file-roller
    nautilus
    eog
    qbittorrent
    nicotine-plus
    nocturne
    vlc
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    chromium
    
    libreoffice
    hunspellDicts.en-gb-ise
    hunspellDicts.en-us
    hunspellDicts.ru-ru

    zoom-us
    figma-linux
    telegram-desktop
  ];
}
