{ inputs, moduleWithSystem, ... }:
{
  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    };

  flake.modules.nixos.users-raven = moduleWithSystem (
    { self', ... }:
    {
      nixpkgs.overlays = [
        (_: prev: {
          inherit (self'.packages)
            waydroid-choose-gpu
            waydroid-script
            ;
        })
      ];
    }
  );

  flake.modules.homeManager.users-raven = moduleWithSystem (
    { self', ... }:
    {
      nixpkgs.overlays = [
        (_: prev: {
          inherit (self'.packages)
            blender
            bottles
            generate
            helium
            neuralrack
            obs-studio
            papirus-folders
            pinentry-dms
            prismlauncher-unwrapped
            qt6ct
            ratatouille
            reaper
            sioyek
            starship-jj
            wiiudownloader
            ;
        })
      ];
    }
  );
}
