{
  description = "A astro project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    tree-sitter-astro = {
      url = "github:virchau13/tree-sitter-astro";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    tree-sitter-astro,
  }: let
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
    tree-sitter-astro-grammar = pkgs.tree-sitter.buildGrammar {
      language = "astro";
      version = "0.0.1";
      src = tree-sitter-astro;
    };
  in {
    formatter."x86_64-linux" = pkgs.alejandra;
    devShells."x86_64-linux".default = pkgs.mkShell {
      packages = with pkgs; [
        nodejs
        nodePackages.pnpm

        typos

        nixd
        tree-sitter-grammars.tree-sitter-nix


        tree-sitter-astro-grammar
        tree-sitter-grammars.tree-sitter-css
        tree-sitter-grammars.tree-sitter-html
        tree-sitter-grammars.tree-sitter-typescript
      ];
    };
  };
}