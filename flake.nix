{
  description = "My Reed College senior thesis";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    chromacode-src = {
      url = "github:TomLebeda/chroma_code";
      flake = false;
    };
    tree-sitter-wrapped = {
      url = "github:Samasaur1/tree-sitter-wrapped";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      tree-sitter-wrapped,
      ...
    }:
    let
      allSystems = nixpkgs.lib.systems.flakeExposed;
      forAllSystems = nixpkgs.lib.genAttrs allSystems;
      define =
        f:
        forAllSystems (
          system:
          let
            pkgs = import nixpkgs {
              inherit system;
              config =
                {
                };
            };
          in
          f pkgs
        );
      rev = if self ? rev then self.rev else throw "Refusing to build from a dirty Git tree!";
    in
    {
      packages = define (pkgs: {
        thesis = pkgs.callPackage ./. {
          inherit rev inputs;
          inherit (self) shortRev lastModified;
        };
        thesis-forbinding = pkgs.callPackage ./. {
          inherit rev inputs;
          inherit (self) shortRev lastModified;
          foliobinding = true;
        };
      });

      devShells = define (pkgs: {
        thesis = pkgs.callPackage ./shell.nix { inherit inputs; };
      });

      formatter = define (pkgs: pkgs.nixfmt-rfc-style);
    };
}
