{
  description = "Home Manager configuration of Raven";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-librewolf.url = "github:nixos/nixpkgs?rev=7a3eeaaac65d8a99b6bdcc79aa5082c80050f992";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
       pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.nur.overlays.default
        ];
        };
        pkgs-librewolf = import inputs.nixpkgs-librewolf {
          inherit system;
        };
    in
    {
    nixosConfigurations.raven = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/raven
        ];
      };
      homeConfigurations.raven = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
        inputs.catppuccin.homeModules.catppuccin
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
        ./homes/raven
        ];
      };
    };
}
