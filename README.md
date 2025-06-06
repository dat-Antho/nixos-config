[![flake-bump](https://github.com/dat-Antho/nixos-config/actions/workflows/flake-bump.yml/badge.svg?branch=master)](https://github.com/dat-Antho/nixos-config/actions/workflows/flake-bump.yml)

## Nixos config

### Nixos 
Zeno : main pc

Aurele : laptop 

### Home-manager

Mark : vps

Revan : dev vm


# Todo first : Enable flakes

https://nixos.wiki/wiki/flakes


# Home manager only systems

Think to set in /etc/nix/nix.conf
```
trusted-users = root anthony # set correct username here
```


## For nixos systems

- move /etc/nix/nixos/* into the nixos-configs directory
- update the flake to configure the nixos system
- nixos-rebuild switch --flake .#aurele (example to build aurele)


### Get photos from ios 
```
# 1. Create a mount point
mkdir -p ~/iPhone

# 2. Plug in and unlock your iPhone

# 3. Pair your device (trust prompt will appear on iPhone)
idevicepair pair

# 4. Mount the iPhone
ifuse ~/iPhone

# 5. Copy photos to your local folder
cp -r ~/iPhone/DCIM ~/Pictures/iPhone_Backup

# 6. Unmount when done
fusermount -u ~/iPhone

