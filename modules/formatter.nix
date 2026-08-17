{ inputs, ... }:
{
  imports = [
    inputs.git-hooks-nix.flakeModule
  ];
  perSystem = {
    pre-commit.settings.hooks = {
      nixfmt.enable = true;
      check-merge-conflicts.enable = true;
      detect-private-keys.enable = true;
      end-of-file-fixer.enable = true;
      trim-trailing-whitespace.enable = true;
    };

  };
}
