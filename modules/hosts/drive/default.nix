top@{ self, inputs, lib, ... }: {
  flake.nixosConfigurations.drive = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.driveConfiguration
    ];
  };

  perSystem = { system, ... }: {
    packages = lib.optionalAttrs (system == "x86_64-linux") {
      drive = top.config.flake.nixosConfigurations.drive.config.system.build.images.proxmox-lxc;
    };
  };
}
