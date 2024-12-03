{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true; 
    sensibleOnTop = true;
  };

}
