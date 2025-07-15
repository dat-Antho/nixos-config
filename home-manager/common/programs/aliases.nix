#used to share aliases, return all the common aliases merged with the "extra"
{
  username,
  extra ? { },
}:

let
  common = {
    ll = "ls -alh";
    gs = "git status";
    #  update = "nix flake update && home-manager switch --flake ~/.config/nix#${username}";
    nix-clean = "nix-collect-garbage -d && nix store optimise";
    nrb = "nh os boot . -- --accept-flake-config ";
    nrs = "nh os switch . -- --accept-flake-config";
    g = "lazygit";
    fmt = "nix run .#formatter.x86_64-linux -- .";
  };

in
common // extra
