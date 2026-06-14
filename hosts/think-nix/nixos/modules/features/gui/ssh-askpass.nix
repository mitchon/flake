{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    openssh-askpass
  ];

  programs.ssh = {
    enableAskPassword = true;
    askPassword = "${pkgs.openssh-askpass}/libexec/gtk-ssh-askpass";
  };
}
