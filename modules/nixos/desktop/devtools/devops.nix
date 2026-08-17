{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ansible
    
    kubectl
    talosctl
    k9s
    telepresence2
    pinniped

    opentofu
    terraform-ls
    tofu-ls
  ];
}
