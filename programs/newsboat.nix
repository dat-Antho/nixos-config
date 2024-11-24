{ config, pkgs, ... }:
{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    browser = "firefox";
    urls = [
      { url = "https://nixos.org/blog/announcements-rss.xml"; }
      { url = "https://www.reddit.com/r/linux_gaming/top/.rss?sort=top&t=week"; }
      { url = "https://www.gamingonlinux.com/article_rss.php"; }
    ];
  };
}