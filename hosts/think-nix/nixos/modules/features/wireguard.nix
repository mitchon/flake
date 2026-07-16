{
  networking.wg-quick.interfaces = {
    wg0 = {
      autostart = false;
      configFile = "/etc/wireguard/wg0.conf";
    };
  };
}
