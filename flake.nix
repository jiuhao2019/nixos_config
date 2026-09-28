{
  description = "NixOS configuration";

  inputs = {
    # 系统和默认软件包：stable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # 只给需要新版的软件使用
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixpkgs-unstable, ... }: {
    nixosConfigurations = {
      # 这里的 my-nixos 替换成你的主机名
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # 这里的 microvee 也得替换成你的用户名
            home-manager.users.microvee = import ./home.nix;

            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ];
      };
    };
  };
}
