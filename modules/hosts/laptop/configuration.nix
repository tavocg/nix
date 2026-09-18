{ self, ... }: {
  flake.nixosModules.laptopConfiguration = { pkgs, ... }: {
    networking.hostName = "laptop";
    console.keyMap = "la-latin1";

    services.udev.extraRules = ''
      # Keep a stable alias for the built-in camera's primary video node.
      SUBSYSTEM=="video4linux", ENV{ID_SERIAL}=="SunplusIT_Inc_HP_True_Vision_FHD_Camera_DTESU0A9IJSNKT", ATTR{index}=="0", SYMLINK+="webcam0"
    '';

    imports = [
      self.nixosModules.laptopHardware

      self.nixosModules.nixos
      self.nixosModules.gamingSunshine
      self.nixosModules.packages
      self.nixosModules.system
      self.nixosModules.systemDocker
      self.nixosModules.systemPrintingEpsonL3150
      self.nixosModules.systemUSBIPHost
      self.nixosModules.systemUSBIPClient
      self.nixosModules.networkBT
      self.nixosModules.networkManagerIWD
      self.nixosModules.networkTailscale

      self.nixosModules.desktopHyprland
      self.nixosModules.desktopHyprlandAutologin

      self.nixosModules.xmrig
    ];

    local.user = {
      enable = true;
      name = "tavo";
      description = "Gustavo Calvo";
    };

    local.ssh.enable = true;

    environment.systemPackages = [
      pkgs.brightnessctl
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    system.stateVersion = "25.11";
  };
}
