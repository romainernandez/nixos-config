{config, pkgs, ...}:

{
  users.extraUsers.rernandez = {
    createHome = true;
    description = "Romain Ernandez";
    uid = 1000;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" ];
    home = "/home/rernandez";
    shell = pkgs.fish;
    isNormalUser = true;
    name = "rernandez";
    openssh.authorizedKeys.keys = [ ];
    initialPassword = "initialpw";
  };
}
