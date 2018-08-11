# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  
  boot.loader = {
    grub.device = "/dev/nvme0n1p";
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  fileSystems."/data" = {
    label = "data";
    device = "/dev/sda1";
    fsType = "ext4";
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  programs.fish.enable = true;

  users.extraUsers.rernandez = {
    createHome = true;
    description = "Romain Ernandez";
    extraGroups = [ "wheel" "networkmanager" ];
    home = "/home/rernandez";
    shell = pkgs.fish;
    isNormalUser = true;
    name = "rernandez";
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtPamIz16+EcC13ir+igZAzHH4imwD1PYI6thuVm3HB4jGHitYX7zLwJv5YUNSbY4lJrP9Yj/JT3FegBwGTZaFQCnaldbMWHC7JOglU8aya2VShSNbZWx1WdaxgVtDo5tojXa4kAKOybgUS5qqnyqmBM/YTWhMS0FWJ9Gy6tdKmGn8tRC5hMEVe7i+DjaeVvBIHL3LJ0yiOAQOPbJr+E8dHyIOfrgzGCXmWSyTfMMGd7i/0WvqaFNO0P2Sr3dsJEEMm81TQ8SBppu4PWPuyQgRcPBQlB2r2Lk+HPUDJi3kcx5/dTZkjO5YNRs+EBk8ryqDsuXjEeivl6u4xRNDPQE+wgFf/Jfo/3uFPkSbi7ZD/YAkj5DvFuhtZErukRA7FUE0BWaXBMDKyLoA856KMEMm680pxNYR03OqoiCmHWA1PqjGASFpOA7VPKrjzvFQcvtCAemU1E98Qf59seusPNACk1MEg2d8QLFwLYEDyNEQqaFpOHQl6zpxR2dVS9XqPXOa2/VpJuF1dHK5LN3SYjBAwzX2s6UR8livOyIrxcBJv0V3rckcCTAy+8xiyC5P8LQa0P7QqiTjtdUhaNL9Io+KV6suy4uEVJIQOXVe+WA0wqC2d5EFaaNgxVfRaGHUY2acZjPWYTa/3xVvbAshXI45sUBdG+f92qvFV7u6ucvskw== romain.ernandez@gmail.com
" ];
  };

  # List services that you want to enable:
  services.openssh.enable = true; # Enable the OpenSSH daemon.
  
  # Enable CUPS to print documents.
  services.printing.enable = true; # Enable CUPS to print documents.

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "fr";
    xkbOptions = "eurosign:e";
    libinput.enable = true; # Enable touchpad support.
    displayManager.sddm.enable = true; # Enable the KDE Desktop Environment.
    desktopManager.plasma5.enable = true;
    # windowManager.xmonad.enable = true;
  };

  services.httpd = {
    enable = true;
    adminAddr = "romain.ernandez@gmail.com";
    documentRoot = "/webroot";
    enableUserDir = true;
  };
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.networkmanager.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.userControlled.enable = true;
  networking.extraHosts =
  ''
    127.0.0.1 localhost
  '';
  
  networking.wireless.networks = {
    "Linked-Living" = {};
  };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = { 
    enable = true; 
    enableSSHSupport = true; 
  };

  nixpkgs.config = { 
    allowUnfree = true;
    allowBroken = true;
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    chromium
    # composer
    docker_compose
    Fabric
    firefox
    geany
    git
    google-chrome-dev
    libreoffice
    php
    terminator
    vim
    vlc
    wget
  ];
}
