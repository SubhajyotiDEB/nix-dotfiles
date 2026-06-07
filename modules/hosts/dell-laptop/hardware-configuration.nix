{ inputs, ... }:
let
  name = "dell-laptop";
in
{
  flake-file.inputs.nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

  flake.modules.nixos."hosts-${name}" =
    { pkgs, ... }:
    {
      # NOTE: Raw files are treated as external dependencies thus, are a special case for relative imports.
      imports = [
        ./_raw/hardware-configuration.nix
        # ./_raw/disko-configuration.nix
      ];

      nixpkgs.overlays = [
        inputs.nix-cachyos-kernel.overlays.pinned
      ];

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        initrd.luks.devices."luks-20b311c8-b910-414d-8319-5e063de4def0".device =
          "/dev/disk/by-uuid/20b311c8-b910-414d-8319-5e063de4def0";
        kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
        kernelModules = [ "ntsync" ];
        extraModprobeConfig = "options kvm_intel nested=1";
        tmp.cleanOnBoot = true;
      };

      zramSwap.enable = true;
    };
}
