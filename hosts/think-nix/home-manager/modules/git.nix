{ user, ... }: {
  programs.git = {
    enable = true;
    settings.user = {
      name = user;
      email = "kommital@yandex.ru";
    };
  };
}
