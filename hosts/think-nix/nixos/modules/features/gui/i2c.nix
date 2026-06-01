{ pkgs, user, ... }:
{
  boot.kernelModules = [ "i2c-dev" ];
  
  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "i2c-rules";
      destination = "/etc/udev/rules.d/70-i2c.rules";
      text = ''
        ACTION=="add", KERNEL=="i2c-[0-9]*", TAG+="uaccess", GROUP="i2c", MODE="0660"
      '';
    })
  ];

  users.users.${user} = {
    extraGroups = [ "i2c" ];
  };
}
