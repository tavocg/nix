{ self, ... }: {
  flake.nixosModules.driveConfiguration = { pkgs, ... }: {
    networking.hostName = "drive";

    imports = [
      self.nixosModules.nixos
      self.nixosModules.binsh
      self.nixosModules.cr
      self.nixosModules.hosts
      self.nixosModules.shell
      self.nixosModules.ssh
      self.nixosModules.user
    ];

    local.user = {
      enable = true;
      name = "drive";
      description = "Drive";
      extraGroups = [ "wheel" ];
    };

    local.ssh.enable = true;

    security.sudo.wheelNeedsPassword = false;

    environment.systemPackages = with pkgs; [
      git
      neovim
      tmux
      curl
      wget
      htop
      file
      ripgrep
      fd
    ];

    system.stateVersion = "25.11";
  };
}
