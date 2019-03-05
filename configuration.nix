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

  system.stateVersion = "18.09";
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
  services.nfs.server.enable = true;

  networking = {
    networkmanager.enable = true;
    # wireless.enable = true;
    wireless.userControlled.enable = true;
  };
  networking.extraHosts =
  ''
    127.0.0.1 localhost
    ::1  localhost
    192.168.50.3 rernandez-VirtualBox
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # browsers
    firefox google-chrome-dev

    # editors
    geany vscode
    (import ./cfg/vim.nix)

    # applications
    calibre deluge drive franz ffmpeg konversation imagemagick libreoffice steam unrar unzip vlc

    # shells
    terminator

    # development
    ansible
    cheat
    docker_compose
    Fabric 
    fd
    gcc 
    gettext 
    git
    gnumake 
    heroku
    htop
    meld
    nginx
    nodejs-8_x 
    ntfs3g
    pgadmin 
    php 
    pipenv
    python35Full
    sqlite
    sqlitebrowser
    wget
    whois
    vagrant
    yarn

    # others
    openssl
    openvpn
  ]
  ++ (with pkgs.nodePackages; [
    bower
  ])
  ++ (with pkgs.phpPackages; [
    composer
  ])
  ++ (with pkgs.python35Packages; [
    ipython
  ])
  ;
  
  services.mysql = {
    enable = true;
    package = pkgs.mysql;
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql100;
  };
}
