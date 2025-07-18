  { pkgs, ... }:

{
  # General home stuff.
  home.username = "raven";
  home.homeDirectory = "/home/raven";
  home.stateVersion = "25.05"; # DO NOT CHANGE!
  home.packages = [
       (pkgs.catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "mauve" ];
      winDecStyles = [ "classic" ];
    })
       pkgs.helix
       pkgs.legcord
       pkgs.librewolf
       pkgs.ghostty
       pkgs.zapzap
       pkgs.maple-mono.NF
       pkgs.nerd-fonts.jetbrains-mono
       pkgs.kdePackages.kconfig
       pkgs.kdePackages.karousel
       pkgs.kdePackages.kde-gtk-config
       pkgs.kdePackages.kconfig
       pkgs.kdePackages.karousel
       pkgs.kdePackages.kde-gtk-config
       pkgs.libreoffice-qt-fresh
       pkgs.signal-desktop
       pkgs.unzip
       pkgs.unrar
       pkgs.zed-editor-fhs
       pkgs.qbittorrent
       pkgs.catppuccinifier-cli
       pkgs.gsettings-desktop-schemas
       pkgs.youtube-music
       pkgs.obsidian
       
   # Niri dependencies
       pkgs.alacritty
       pkgs.fuzzel
       pkgs.waybar
       pkgs.swaybg
       pkgs.swaylock
       pkgs.font-awesome

   # Python stuff
       (pkgs.python311.withPackages (ps: with ps; [
       ps.pip
       ps.requests
       ps.discordpy
       ]))
       pkgs.ffmpeg
       ];
  # Fontconfig stuff.
  fonts.fontconfig.enable = true;

  # Let home-manager update itself.
  programs.home-manager.enable = true;

  # Allow unfree.
  nixpkgs.config.allowUnfree = true;

   # Catppuccin!
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  #Modules
  imports = [
      ./ghostty.nix
      ./helix.nix
      ./fish.nix
      ./flatpak.nix
      ./kdeconnect.nix
      ];
}
