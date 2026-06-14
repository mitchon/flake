{ user, ... }:
{
  networking.wg-quick.interfaces = {
    wg0 = {
      autostart = false;
      configFile = "/home/${user}/wg0.conf";
    };
  };
}
