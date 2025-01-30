{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "gruvbox-dark-hard";
    font = {
      name = "JetbrainsMono Nerd Font Mono";
      size = 12.0;
    };
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
    };
  };

}
