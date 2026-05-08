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
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        (inputs.import-tree ./modules)
        ./modules/shells
      ];
    };
}
