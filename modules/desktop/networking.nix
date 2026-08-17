{ user, ... }:
{
  users.users.${user}.extraGroups = [ "networkmanager" ];
}
