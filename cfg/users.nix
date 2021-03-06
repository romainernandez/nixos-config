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
    initialPassword = "initialpw";
  };

  environment.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "..2" = "cd ../..";
    "..3" = "cd ../../..";
    "..4" = "cd ../../../..";
    "pp" = "pycharm-professional";
    "cdd" = "cd ~/Documents/";
    "la" = "ls -lah";
    "vc" = "vim /home/rernandez/Documents/nixos-config/";
    "cdc" = "cd /home/rernandez/Documents/nixos-config/";
    "c" = "clear";
    "h" = "history";
    "pytest" = "pytest -s";

    # Git
    "g" = "git";
    "gs" = "git status";
    "ga" = "git add";
    "gc" = "git commit";
    "gd" = "git diff";
    "gist" = "git log --graph --abbrev-commit --date=short --all"; 
    "gp" = "git push";
    "grh" = "git reset HEAD~";
    "gl" = "git log";
  };
}
