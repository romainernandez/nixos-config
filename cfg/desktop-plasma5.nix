{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      layout = "fr";
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      libinput.enable = true; # touchpad support
    };
  };

  environment.systemPackages = with pkgs; [
    kdeApplications.ark
    kdeApplications.gwenview
    kdeApplications.okular
    kdeApplications.dolphin-plugins
    kdeFrameworks.kconfig
    kdeFrameworks.kconfigwidgets
	kdeApplications.spectacle
	kdeplasma-addons
  ];
}
