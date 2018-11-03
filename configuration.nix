{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix  # Include the results of the hardware scan.
    ./cfg/desktop-plasma5.nix
    ./cfg/users.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  system.stateVersion = "18.03";
  system.autoUpgrade.enable = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Vienna";

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  programs.fish.enable = true;

  services.openssh.enable = true; # Enable the OpenSSH daemon.
  services.printing.enable = true; # Enable CUPS to print documents.

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  networking = {
    networkmanager.enable = true;
    # wireless.enable = true;
    wireless.userControlled.enable = true;
    wireless.networks = {
      "Linked-Living" = {};
    };
  };
  networking.extraHosts =
  ''
    127.0.0.1 wordpress.local test.wordpress.local profiling.local localhost composer.yelsterdigital.com
    ::1  localhost
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # basic command line tools
    htop unrar unzip wget whois imagemagick

    # browsers
    firefox google-chrome-dev

    # development
    ffmpeg gcc gettext nodejs php purescript python36Full

    # editors
    geany gnome3.gedit jetbrains.pycharm-professional sublime
    (import ./cfg/vim.nix)

    # games
    steam

    # instant-messengers
    franz

    # misc
    calibre cheat fd terminator

    # office
    libreoffice

    # p2p
    deluge
    
    #tools
    drive

    # version-management
    git meld

    # videos
    vlc

    # virtualization
    docker_compose vagrant ansible

    # web-servers
    nginx
  ]
  ++ (with pkgs.nodePackages; [
    bower
    node2nix
    pulp
  ])
  ++ (with pkgs.python36Packages; [
    docker_compose
    virtualenv
  ])
  ++ (with pkgs.phpPackages; [
    composer
  ])
  ;
  
  services.mysql = {
    enable = true;
    package = pkgs.mysql;
  };
}
