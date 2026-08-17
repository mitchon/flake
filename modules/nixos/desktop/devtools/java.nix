{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    corretto21
    gradle
    maven
  ];

  environment.sessionVariables = {
    JAVA_HOME = pkgs.corretto21;
  };
}
