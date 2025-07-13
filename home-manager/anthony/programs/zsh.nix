{
  config,
  pkgs,
  lib,
  ...
}:
let
  extraAliases = {
    kde-fix-icons = "sed -i 's/file:\/\/\/nix\/store\/[^\/]*\/share\/applications\//applications:/gi' ~/.config/plasma-org.kde.plasma.desktop-appletsrc && systemctl restart --user plasma-plasmashell";
    ghfb = "gh workflow run flake-bump";
    ssh = "kitty +kitten ssh";
    ghfbl = "gh run list --workflow flake-bump.yml";
  };
  aliases = import ../../common/aliases.nix {
    username = config.home.username;
    extra = extraAliases;
  };

in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    # initContent = lib.mkBefore "export LANG=en_US.UTF-8\nexport LC_ALL=en_US.UTF-8 export PATH=\"$HOME/bin:$PATH\"\n autoload -Uz compinit\ncompinit -C\n ";
    initContent = lib.mkBefore "export PATH=\"$HOME/bin:$PATH\"\n autoload -Uz compinit\ncompinit -C\n ";
    shellAliases = aliases;
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
