{ config
, pkgs
, ...
}: {
  programs.git = {
    enable = true;
    userEmail = "16465475+dat-Antho@users.noreply.github.com";
    userName = "anthony";
  };
}
