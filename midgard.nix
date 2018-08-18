{ config, pkgs, ... }:

{
  imports = [
    cfg/base-small.nix
    cfg/desktop-plasma5.nix
    cfg/users.nix
  ];
  
  system.stateVersion = "18.03"; # Did you read the comment?
  system.autoUpgrade.enable = true;
  
  boot.loader = {
    enable = true;
    grub.device = "/dev/nvme0n1p";
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  fileSystems."/data" = {
    label = "data";
    device = "/dev/sda1";
    fsType = "ext4";
  };

  programs.fish.enable = true;

  services.openssh.enable = true; # Enable the OpenSSH daemon.
  services.printing.enable = true; # Enable CUPS to print documents.

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "fr";
    xkbOptions = "eurosign:e";
    libinput.enable = true; # Enable touchpad support.
  };
  
  networking = {
    hostName = "midgard";
    networkmanager.enable = true;
    wireless.enable = true;
    wireless.userControlled.enable = true;
    wireless.networks = {
      "Linked-Living" = {};
    };
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # composer
    docker_compose
    Fabric
    firefox
    geany
    gedit
    git
    google-chrome-dev
    libreoffice
    meld
    nginx
    php
    terminator
    vim
    vlc
    wget
    transmission_gtk
  ];
}
