{ pkgs, ... }:
{
  plugins.luasnip = {
    enable = true;

    fromVscode = [
      {
        paths = "${pkgs.vimPlugins.friendly-snippets}";
      }
    ];
  };

}
