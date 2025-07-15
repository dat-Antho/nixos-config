{
  config,
  pkgs,
  ...
}:
{
  home.username = "anthony";
  home.homeDirectory = "/home/anthony";

  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
  imports = [
    ../common/programs/nixvim.nix
    (import ../../common/programs/zsh-base.nix {
      extraAliases = {
      };
    })
  ];
  home.packages = with pkgs; [
    git
    nh
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
  services.syncthing.enable = true;
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
