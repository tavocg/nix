{ self, ... }: {
  flake.nixosModules.environmentVariables = { ... }: {
    environment.sessionVariables = {
      PASSWORD_STORE_DIR = "\${XDG_DATA_HOME:-$HOME/.local/share}/password-store";
      GNUPGHOME = "\${XDG_DATA_HOME:-$HOME/.local/share}/gnupg";
    };
  };
}
