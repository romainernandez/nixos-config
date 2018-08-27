{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix  # Include the results of the hardware scan.
    ./cfg/desktop-plasma5.nix
    ./cfg/users.nix
  ];

  boot.loader = {
    grub.device = "/dev/nvme0n1p";
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  fileSystems."/data" = {
    label = "data";
    device = "/dev/sda1";
    fsType = "ext4";
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
  
  networking = {
    hostName = "midgard";
    networkmanager.enable = true;
    # wireless.enable = true;
    wireless.userControlled.enable = true;
    wireless.networks = {
      "Linked-Living" = {};
    };
  };
  networking.extraHosts =
  ''
    127.0.0.1 wordpress.local test.wordpress.local profiling.local localhost
    ::1  localhost
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cheat
    docker_compose
    Fabric
    fd
    ffmpeg
    firefox
    franz
    gcc
    geany
    gettext
    gnome3.gedit
    gnumake
    git
    google-chrome-dev
    htop
    httpie
    httpstat
    libffi
    libreoffice
    meld
    nginx
    nodejs
    php
    pipenv
    purescript
    jetbrains.pycharm-professional
    python36Full
    stdenv
    steam
    sublime
    terminator
    unzip
    vim
    vlc
    wget
    whois
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
