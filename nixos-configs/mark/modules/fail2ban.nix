{ config
, pkgs
, ...
}: {
  services.fail2ban = {
    enable = true;

    bantime = "10m";

    banaction = "iptables-multiport";

    maxretry = 3;

    bantime-increment = {
      enable = true;
      factor = "2";
      formula = "bantime * (factor ** (attempts - 1))";
      maxtime = "2h";
    };

    jails = {
      sshd.settings = {
        enabled = true;
        findtime = "10m";
      };
      recidive.settings = {
        enabled = true;
        logpath = "/var/log/fail2ban.log";
        bantime = "7d";
        findtime = "2d";
        maxretry = 5;
      };

    };
  };
}
