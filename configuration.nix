# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cfg/users.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    networkmanager.enable = true;
    # wireless.enable = true;
    wireless.userControlled.enable = true;
  };
  # networking.hostName = "nixos"; # Define your hostname.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # browsers
    firefox google-chrome-dev

    # editors
    geany jetbrains.pycharm-professional
    (import ./cfg/vim.nix)

    # applications
    deluge ffmpeg konversation imagemagick libreoffice steam unrar unzip vlc okular

    # shells
    terminator

    # development
    cheat
    clojure
    docker_compose
    Fabric 
    fd
    gcc 
    gettext 
    git
    gnumake 
    htop
    lsof
    meld
    nginx
    nodejs-8_x 
    ntfs3g
    pgadmin 
    php 
    pipenv
    python37Full
    sqlite
    sqlitebrowser
    wget
    whois
    yarn
  ]
  ++ (with pkgs.python37Packages; [
    virtualenv
  ])
  ;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  programs.fish.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "fr";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  networking.extraHosts =
  ''
    127.0.0.1 localhost
    ::1  localhost
  '';
  
  networking.networkmanager.dns = lib.mkForce "none"; # networkmaneger not to overwrite /etc/resolv.conf
  services.resolved.enable = lib.mkForce false; # just to be sure
  environment.etc."resolv.conf" = {
    text = lib.optionalString (config.networking.nameservers != []) (
       lib.concatMapStrings (ns: "nameserver ${ns}\n") config.networking.nameservers
     );
    mode = "0444";
  };
  
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
