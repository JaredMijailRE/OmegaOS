{ config, pkgs, ... }:

{
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

      imports =
    [
      ./hosts/yoga7i/configuration.nix
    ];

    environment.systemPackages = with pkgs; [
        nvim 
        git
    ];

  system.stateVersion = "25.05"; 
}