{ config
, pkgs
, ...
}:
{
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
    python311Full
    python311Packages.pip
    python311Packages.virtualenv
    python311Packages.mypy
    poetry
    gitflow
    tldr
    lazygit
    gcc
    stdenv.cc.cc.lib
    libgcc
    gnumake
    cmake
    extra-cmake-modules
    zlib
    nh
    httpie
  ];
  imports = [
    ../common/programs/nixvim.nix
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
