{config, pkgs, ...}:

{
  nix.trustedUsers = [ "root" "rernandez" "vagrant" ];
  
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
    "cdd" = "cd ~/Documents/";
    "la" = "ls -lah";
    "vc" = "vim /home/rernandez/Documents/nixos-config/";
    "cdc" = "cd /home/rernandez/Documents/nixos-config/";

    # Git
    "gs" = "git status";
    "ga" = "git add";
    "gc" = "git commit";
    "gd" = "git diff";
    "gist" = "git log --graph --abbrev-commit --date=short --all"; 
  };
}
