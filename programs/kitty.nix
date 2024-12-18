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
    dynamic_background_opacity = true;
    enable_audio_bell = false;
    background_opacity = "0.7";
    background_blur = 5;
  };
  };

}
