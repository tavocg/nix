NIX_MAX_JOBS ?= 1
NIX_CORES ?= 1
NIX_BUILD_FLAGS = --max-jobs $(NIX_MAX_JOBS) --cores $(NIX_CORES)

all: switch

.PHONY: switch
switch:
	nixos-rebuild switch --flake . $(NIX_BUILD_FLAGS)

.PHONY: boot
boot:
	nixos-rebuild boot --flake . $(NIX_BUILD_FLAGS)

.PHONY: drive
drive:
	nix build .#drive $(NIX_BUILD_FLAGS)

.PHONY: update
update:
	nix flake update

.PHONY: test
test:
	nixos-rebuild test --flake . $(NIX_BUILD_FLAGS)

.PHONY: verify
verify:
	nix store verify --all

.PHONY: repair
repair:
	nix store verify --all 2>&1 | awk -F"'" '/was modified!/ {print $$2}' | xargs -r nix store repair

.PHONY: clean-garbage
clean-garbage:
	nix-collect-garbage -d
	nix-collect-garbage
