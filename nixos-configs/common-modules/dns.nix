{
  config,
  pkgs,
  lib,
  ...
}:
{

  networking.useHostResolvConf = false;

  # Forward all DNS to dnscrypt-proxy (local stub resolver)
  networking.nameservers = [ "127.0.0.1" ];

  services.dnscrypt-proxy2 = {
    enable = true;

    settings = {
      ipv4_servers = true;
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;
      doh_servers = true;
      dnscrypt_servers = true;

      # You can choose resolvers from https://dnscrypt.info/public-servers
      server_names = [
        "cloudflare"
        "quad9-doh"
      ];
    };
  };
}
