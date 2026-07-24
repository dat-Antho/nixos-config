{
  ...
}:
{

  flake.nixosModules.music-player = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      supersonic
    ];
  };

}
