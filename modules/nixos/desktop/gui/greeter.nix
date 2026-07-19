{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --remember-session --user-menu --time --cmd niri-session";
      user = "greeter";
    };
  };
}
