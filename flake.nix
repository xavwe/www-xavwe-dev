{
  description = "A astro project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".alejandra;
    devShells."x86_64-linux".default = nixpkgs.legacyPackages."x86_64-linux".mkShell {
      packages = with nixpkgs.legacyPackages."x86_64-linux"; [
        nodejs
        nodePackages.pnpm

        nixd
        tree-sitter-grammars.tree-sitter-nix
      ];
    };
  };
}