_: {
  # defining some useful variables to propagate,
  # see:
  #   _module.args : everything starts here because the whole nix config use
  #   flake-parts
  #   specialArgs in mkNixos : usefull to propagate vars in nixos modules
  _module.args = {
    network = {
      domains = {
        vps = "datantho.ovh";
        main = "anthonyhengy.fr";
      };
    };
    system = {
      users = {
        main = "anthony";
        dev = "ahengy";
      };
    };
  };
}
