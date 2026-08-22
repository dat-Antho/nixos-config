{
  config,
  ...
}:
let
  domain = "syncp.datantho.ovh";
in
{

  sops.secrets."syncplay" = {
    sopsFile = ../../../../secrets/syncplay.yaml;
    format = "yaml";
    key = "password";
    mode = "0400";
  };
  services = {
    nginx = {

      virtualHosts.${domain} = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8999";
        };
      };
    };
    syncplay = {
      enable = true;
      interfaceIpv4 = "127.0.0.1";
      port = 8999;
      chat = false;
      passwordFile = config.sops.secrets."syncplay".path;
      useACMEHost = domain;
    };
  };

}
