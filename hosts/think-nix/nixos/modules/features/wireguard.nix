{ user }:
{
  networking.wg-quick.interfaces = {
    wg0 = {
      configFile = "/home/${user}/wg0.conf";
    };
  };
}
