all: switch

.PHONY: switch
switch:
	nixos-rebuild switch --flake .

.PHONY: boot
boot:
	nixos-rebuild boot --flake .

.PHONY: update
update:
	nix flake update

.PHONY: test
test:
	nixos-rebuild test --flake .

.PHONY: clean-garbage
clean-garbage:
	nix-collect-garbage -d
	nix-collect-garbage
