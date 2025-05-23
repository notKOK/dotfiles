{
  description = "Danila flake! UGA-BUGA! MONKEY STRONG TOGETHER!";

  inputs = {
    nixos-24-11.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixos-25-05.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    nixos-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nixpkgs.follows = "nixos-25-05";
    nixpkgs_unstable.follows = "nixos-unstable";

    nvf.url = "github:notashelf/nvf";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs_unstable,
    nvf,
    #sops-nix,
    ...
  }: let
    system = "x86_64-linux";
  in {
    packages.${system}.my-neovim =
      (
        nvf.lib.neovimConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./nvf-configuration.nix
          ];
        }
      )
      .neovim;

    nixosConfigurations = {
      DanilaNix = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ({pkgs, ...}: {
            environment.systemPackages = [
            ];
          })
          ./configuration.nix
          ({pkgs, ...}: {
            environment = {
              variables = {
                MANPAGER = "nvim +Man!";
              };
              systemPackages = [
                self.packages.${system}.my-neovim
              ];
              variables.EDITOR = "${self.packages.${system}.my-neovim}/bin/nvim";
              variables.SUDO_EDITOR = "${self.packages.${system}.my-neovim}/bin/nvim";
            };
          })
        ];
      };
    };
  };
}
