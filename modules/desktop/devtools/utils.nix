{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jetbrains.idea
    zed-editor

    codex
    
    lazygit
    lazydocker
    lazysql
    postman
  ];
}
