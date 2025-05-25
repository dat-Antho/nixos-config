[![flake-bump](https://github.com/dat-Antho/nixos-config/actions/workflows/flake-bump.yml/badge.svg?branch=master)](https://github.com/dat-Antho/nixos-config/actions/workflows/flake-bump.yml)

## Nixos config

Zeno : main pc
Aurele : laptop 
Mark : vps


# Todo first : Enable flakes

https://nixos.wiki/wiki/flakes


# Home manager

Think to set in /etc/nix/nix.conf
```
trusted-users = root anthony # set correct username here
```


## For nixos systems

- move /etc/nix/nixos/* into the nixos-configs directory
- update the flake to configure the nixos system
- nixos-rebuild switch --flake .#aurele (example to build aurele)
