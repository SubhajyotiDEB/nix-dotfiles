{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/hosts/common-settings.nix
    ../../modules/hosts/trusted-substituters.nix
    ../../modules/hosts/security.nix
    ../../modules/hosts/netmod.nix
    ../../modules/hosts/bluetooth.nix
    ../../modules/hosts/pipewire.nix
    ../../modules/hosts/graphics.nix
  ];

  # Some stuff that should exist independently.
  system.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;

  # Firmware stuff.
  services.fwupd.enable = true;

  # Fine-grained boot stuff.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  boot.kernelPackages = pkgs.linuxPackages_6_17;
  boot.initrd.luks.devices."luks-899727ff-652c-474e-88dc-a8f7583978bc".device =
    "/dev/disk/by-uuid/899727ff-652c-474e-88dc-a8f7583978bc";

  # Zram stuff.
  zramSwap.enable = true;

  #command-not-found bs
  programs.command-not-found.enable = false;

  # Fine-grained localization stuff.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Miscellaneous stuff.
  common-settings.enable = true;
  common-settings.flake = "/home/raven/nix-config";
  common-settings.gc.options = "--delete-older-than 7d";
  trusted-substituters.enable = true;
  security.enable = true;

  # Networking stuff.
  netmod.enable = true;
  netmod.name = "raven";

  # Media stuff.
  bluetooth.enable = true;
  pipewire.enable = true;

  # Display Manager stuff.
  services.displayManager.ly.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = [
    pkgs.kdePackages.discover
    pkgs.kdePackages.elisa
  ];

  # Niri
  programs.niri.enable = true;

  # Graphics stuff.
  graphics.enable = true;
  graphics.nvidia.enable = true;
  graphics.nvidia.prime.enable = true;
  graphics.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # Flatpak stuff.
  services.flatpak.enable = true;

  # AppImage stuff.
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      pkgs.libxcrypt
      pkgs.icu
    ];
  };

  # Nix-ld.
  programs.nix-ld.enable = true;

  # OpenSHH
  services.openssh.enable = true;

  # Me!
  users.users.raven = {
    isNormalUser = true;
    description = "Raven";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "bluetooth"
      "libvirtd"
      "kvm"
    ];
  };

  # XDG portal configuration for Wayland
  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # Variables stuff.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ZED_WINDOW_DECORATIONS = "server";
    SIGNAL_PASSWORD_STORE = "kwallet6";
  };
}
