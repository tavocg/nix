{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    dotfiles = {
      url = "gitlab:tavocg/dotfiles";
      flake = false;
    };
    shtatus = {
      url = "github:tavocg/shtatus";
      flake = false;
    };
    anypinentry.url = "github:tavocg/anypinentry";
    kanban.url = "github:tavocg/kanban";
    codex-nix.url = "github:SecBear/codex-nix";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
