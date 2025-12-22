{ pkgs, pkgs-librewolf, ... }:

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
    pkgs.legcord
    pkgs.zapzap
    pkgs.duckdb
    pkgs.maple-mono.NF
    pkgs.nerd-fonts.jetbrains-mono
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
    pkgs.bitwarden-desktop
    pkgs.uv
    pkgs.git
    pkgs.git-lfs
    (pkgs.bottles.override {
      removeWarningPopup = true;
    })
    pkgs.wl-clipboard

    #Rust pkgs
    pkgs.rustup
    pkgs.gcc

    #LSP pkgs
    pkgs.fish-lsp
    pkgs.nixd
    pkgs.nix-search-tv
    pkgs.nixfmt-rfc-style
    pkgs.nix-output-monitor
    pkgs.simple-completion-language-server
    pkgs.taplo
    pkgs.vscode-langservers-extracted
    pkgs.yaml-language-server

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
    ./starship.nix
    ./git.nix
    ./direnv.nix
    ./yazi.nix
    ./eza.nix
    ./fzf.nix
    ./atuin.nix
    ./niri.nix
    ./librewolf.nix
  ];
}
