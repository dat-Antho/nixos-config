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
        };
      };
    };
    syncplay = {
      enable = true;

      extraArgs = [
        "--ipv4-only"
      ];

      port = 8999;
      chat = false;
      passwordFile = config.sops.secrets."syncplay".path;
      useACMEHost = domain;
    };
  };

}
