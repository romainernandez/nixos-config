{ config, pkgs, lib, ... }:

{
  imports =
    [ 
      ../hardware-configuration.nix  # Include the results of the hardware scan.
    ];

  system.stateVersion = "18.03"; # Did you read the comment?
  system.autoUpgrade.enable = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Vienna";
  
  nixpkgs.config = { 
    allowUnfree = true;
    allowBroken = true;
  };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  
  environment.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "..2" = "cd ../..";
    "..3" = "cd ../../..";
    "..4" = "cd ../../../..";
  };
}
