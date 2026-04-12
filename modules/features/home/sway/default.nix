{ self, inputs, ... }: {
  flake.homeModules.sway = {
    wayland.windowManager.sway.enable = true;
    xdg.configFile."sway/config".source = "${inputs.dotfiles}/sway/config";

    imports = [
      self.homeModules.swayFoot
      self.homeModules.swayPrograms
    ];
  };
}
