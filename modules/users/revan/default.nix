{ self, inputs, ... }:

{
  flake = {
    homeConfigurations."revan" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        self.homeModules.revan-module
      ];
    };

    homeModules.revan-module =
      { pkgs, ... }:
      {
        imports = [
          self.homeModules.cli-apps
        ];

        # Home Manager needs a bit of information about you and the paths it should
        # manage.
        home.username = "ahengy";
        home.homeDirectory = "/home/ahengy";

        # This value determines the Home Manager release that your configuration is
        # compatible with. This helps avoid breakage when a new Home Manager release
        # introduces backwards incompatible changes.
        #
        # You should not change this value, even if you update Home Manager. If you do
        # want to update the value, then make sure to first check the Home Manager
        # release notes.
        home.stateVersion = "24.11"; # Please read the comment before changing.

        # The home.packages option allows you to install Nix packages into your
        # environment.
        home.packages = with pkgs; [
          gitflow
          tldr
          lazygit
          nh
          zellij
          k9s
        ];
        programs.uv = {
            enable = true;
        
            python = {
              versions = [ "3.14" "3.13" "3.12" "3.11" ];
              default = [ "3.11" ];
              prune = true;
            };
        
            tool = {
              packages = ["poetry" "nox" ];
              prune = true;
            };
          };
        home.sessionVariables = {
          EDITOR = "nvim";
        };
        programs.zsh.shellAliases = {
          hmrs = "nh home switch --accept-flake-config ~/nixos-config -c revan";
        };
        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;
      };
  };
}
