{ config
, pkgs
, lib
, ...
}:
{
  imports = [
    (import ../../common/programs/zsh-base.nix {
      extraAliases = {
        kde-fix-icons = "sed -i 's/file:\/\/\/nix\/store\/[^\/]*\/share\/applications\//applications:/gi' ~/.config/plasma-org.kde.plasma.desktop-appletsrc && systemctl restart --user plasma-plasmashell";
        ghfb = "gh workflow run flake-bump";
        ssh = "kitty +kitten ssh";
        ghfbl = "gh run list --workflow flake-bump.yml";
      };
    })
  ];
}
