{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";

    dotfiles = {
      url = "gitlab:tavocg/dotfiles";
      flake = false;
    };

    # not currently wired into any module.
    # wrapper-modules = {
    #   url = "github:BirdeeHub/nix-wrapper-modules";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    shtatus = {
      url = "github:tavocg/shtatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kanban = {
      url = "github:tavocg/kanban";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    st = {
      url = "github:tavocg/st";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pinentry-bemenu = {
      url = "github:tavocg/pinentry-bemenu";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    codex-nix = {
      url = "github:SecBear/codex-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
