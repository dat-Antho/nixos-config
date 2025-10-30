[![flake-bump](https://github.com/dat-Antho/nixos-config/actions/workflows/flake-bump.yml/badge.svg?branch=master)](https://github.com/dat-Antho/nixos-config/actions/workflows/flake-bump.yml)
[![flake-check](https://github.com/dat-Antho/nixos-config/actions/workflows/flake-bump.yml/badge.svg?branch=master)](https://github.com/dat-Antho/nixos-config/actions/workflows/flake-check.yml)


## Nixos config

### Nixos 
Zeno : main pc

Aurele : laptop 

Mark : vps
### Home-manager


Revan : dev vm


# Todo first : Enable flakes

https://nixos.wiki/wiki/flakes


# Home manager only systems

Think to set in /etc/nix/nix.conf
```
trusted-users = root anthony # set correct username here
substituters = https://datantho-nixos.cachix.org https://cache.nixos.org https://nix-community.cachix.org
trusted-public-keys = datantho-nixos.cachix.org-1:e1Wvy2MQcqrTm5Vedsat55IrNNZRqYvJppfbjMECXOE= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
```


## For nixos systems

- move /etc/nix/nixos/* into the nixos-configs directory
- update the flake to configure the nixos system
- nixos-rebuild switch --flake .#aurele (example to build aurele)

