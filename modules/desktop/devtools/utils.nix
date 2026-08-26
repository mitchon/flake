{ inputs, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jetbrains.idea
    zed-editor

    codex
    
    lazygit
    lazydocker
    lazysql
    postman
    inputs.chatgpt.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
