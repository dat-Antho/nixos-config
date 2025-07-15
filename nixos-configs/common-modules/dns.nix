{ config
, pkgs
, lib
, ...
}:
{

  networking.useHostResolvConf = false;

  # Forward all DNS to dnscrypt-proxy (local stub resolver)
  networking.nameservers = [ "127.0.0.1" ];
  networking.networkmanager.dns = lib.mkForce "none";
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      listen_addresses = [ "127.0.0.1:5300" ]; # custom port
      ipv4_servers = true;
      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;
      doh_servers = true;
      dnscrypt_servers = true;
      cache = true;
      cache_size = 4096;
      cache_min_ttl = 240;
      cache_max_ttl = 86400;

      # You can choose resolvers from https://dnscrypt.info/public-servers
      server_names = [
        "cloudflare"
        "quad9-doh"
      ];
    };
  };

  services.blocky = {
    enable = true;
    settings = {
      # use at service startup, if it's not set we get dns error
      # bootstrapdns !== upstreams dns
      bootstrapDns = "1.1.1.1";
      ports.dns = 53;
      upstreams.groups.default = [ "127.0.0.1:5300" ];
      blocking = {
        denylists = {
          ads = [ "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" ];
        };
        clientGroupsBlock = {
          default = [ "ads" ];
        };
      };
      caching = {
        minTime = "5m";
        maxTime = "30m";
        prefetching = true;
      };
    };

  };

}
