{ username ? "anthony"
, extraAliases ? { }
,
}:

{ config
, lib
, pkgs
, ...
}:

let
  commonAliases = import ./aliases.nix {
    inherit username;
    extra = extraAliases;
  };
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";

    initContent = lib.mkBefore ''
            export PATH="$HOME/bin:$PATH"
            autoload -Uz compinit
            compinit -C

      fcd() {
        local dir
         dir=$(fd . ~/ /mnt -t d --hidden --exclude .git 2>/dev/null \
          | fzf --preview 'exa -T --color=always {} | head -40') || return
        cd "$dir"
      }

    '';

    shellAliases = commonAliases;

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
