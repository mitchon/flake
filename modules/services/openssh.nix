{
  services.openssh = {
    enable = true;
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
    listenAddresses = [
      { addr = "192.168.2.53"; port = 22; }
    ];
  };
}
