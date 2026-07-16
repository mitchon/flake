{
  services.openvpn.servers = {
    work = {
      autoStart = false;
      config = "config /etc/openvpn/configuration.ovpn";
      updateResolvConf = true;
    };
  };
}