{
  description = "Flake for NixOS";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nathan.url = "github:poollovernathan/nixos";
  };
  
  outputs = { self, nixpkgs, home-manager, nathan }: {
    
    nixosConfigurations = {  
      NixOS-Desktop = nixpkgs.lib.nixosSystem {
          
        system = "x86_64-linux"; 
        modules = [
          ./configuration.nix
          ./host-specific/desktop/hardware-configuration.nix
          ./host-specific/desktop/stateVersion.nix
          ./services.nix
          ./packages.nix
          ./host-specific/nvidia-drivers.nix
          ./packages/chromium.nix

          nathan.nixosModules.nathan

          # User Specific
#          home-manager.nixosModules.home-manager {
#            home-manager.useGlobalPkgs = true;
#            home-manager.useUserPackages = true;
#            home-manager.users.bunny = import ./home.nix;
#          }
        ];
      };

      NixOS-Laptop = nixpkgs.lib.nixosSystem {
          
        system = "x86_64-linux"; 
        modules = [
          ./configuration.nix
          ./host-specific/laptop/hardware-configuration.nix
          ./host-specific/laptop/stateVersion.nix
          ./services.nix
          ./packages.nix
          
          # User Specific
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bunny = import ./bunny/home.nix;
          }
        ];
      };
    };
  };
}
