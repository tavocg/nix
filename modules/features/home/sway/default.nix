{ self, inputs, ... }: {
  flake.homeModules.sway = {
    imports = [
      self.homeModules.swayFoot
      self.homeModules.swayPrograms
    ];

    xdg.configFile."sway/config".source = "${inputs.dotfiles}/sway/config";
  };
}
