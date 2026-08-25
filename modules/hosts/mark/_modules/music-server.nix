{ network, ... }:
let
  vhost = "music.${network.domains.vps}";
in
{
  services.navidrome = {
    enable = true;
    settings.MusicFolder = "/audio/music";
  };
  services.nginx = {
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."${vhost}" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:4533";
        proxyWebsockets = true;
      };
    };
  };

}
