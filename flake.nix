{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    roclang = { url = "github:roc-lang/roc"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs = {self, nixpkgs, nixos-hardware, ... }@inputs: {
    nixosConfigurations.venus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
	nixos-hardware.nixosModules.framework-12th-gen-intel
      ];
    };
  };
}

