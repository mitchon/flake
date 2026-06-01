{ hostname, user, ... }:
{
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  users.users.${user} = {
    extraGroups = [ "networkmanager" ];
  };
}
