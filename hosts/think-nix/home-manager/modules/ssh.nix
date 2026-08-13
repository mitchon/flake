{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "homelab" = {
        hostname = "192.168.2.53";
        user = "mitchanx";
      };
      "git.int.mitchanx.ru" = {
        hostname = "git.int.mitchanx.ru";
        port = 23;
      };
    };
  };
}
