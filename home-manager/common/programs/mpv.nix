{ config
, pkgs
, ...
}: {
  programs.mpv = {
    enable = true;
    package = (
      pkgs.mpv-unwrapped.wrapper {
        scripts = with pkgs.mpvScripts; [
          uosc
          sponsorblock
        ];

        mpv = pkgs.mpv-unwrapped.override {
          waylandSupport = true;
        };
      }
    );
    config = {
      vo = "gpu";
      gpu-api = "opengl";
    };
  };
}
