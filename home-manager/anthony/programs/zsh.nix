{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    initExtraFirst = "export LANG=en_US.UTF-8\nexport LC_ALL=en_US.UTF-8 export PATH=\"$HOME/bin:$PATH\"";
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      kde-fix-icons = "sed -i 's/file:\/\/\/nix\/store\/[^\/]*\/share\/applications\//applications:/gi' ~/.config/plasma-org.kde.plasma.desktop-appletsrc && systemctl restart --user plasma-plasmashell";
      nrb = "sudo nixos-rebuild boot --flake .";
      nrs = "sudo nixos-rebuild switch --flake .";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "MichaelAquilina/zsh-you-should-use"; }
        {
          name = "mafredri/zsh-async";
          tags = [ "from:github" ];
        }
        {
          name = "sindresorhus/pure";
          tags = [
            "as:theme"
            "use:pure.zsh"
            "from:github"
          ];
        }
      ];
    };
  };

}
