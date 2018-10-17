{config, pkgs, ...}:

{
  nix.trustedUsers = [ "root" "rernandez" ];

  users.extraUsers.rernandez = {
    createHome = true;
    description = "Romain Ernandez";
    uid = 1000;
    group = "users";
    extraGroups = [ "wheel" "networkmanager" "docker"];
    home = "/home/rernandez";
    shell = pkgs.fish;
    isNormalUser = true;
    name = "rernandez";
    openssh.authorizedKeys.keys = [ ];
    initialPassword = "initialpw";
  };

  environment.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "..2" = "cd ../..";
    "..3" = "cd ../../..";
    "..4" = "cd ../../../..";
    "pp" = "pycharm-professional";
    "cdwp" = "cd ~/Documents/Yelster/wordpress-dev/wordpress/";
    "cdwpp" = "cd ~/Documents/Yelster/wordpress-dev/wordpress/web/wp-content/plugins/";
    "sdn" = "shutdown -h now";
  };
}
