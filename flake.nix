{
  description = "My Reed College senior thesis";

  outputs =
    {
      self,
      nixpkgs,
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
          inherit rev;
          inherit (self) shortRev lastModified;
        };
        thesis-forbinding = pkgs.callPackage ./. {
          inherit rev;
          inherit (self) shortRev lastModified;
          foliobinding = true;
        };
      });

      devShells = define (pkgs: {
        thesis = pkgs.callPackage ./shell.nix { };
      });

      formatter = define (pkgs: pkgs.nixfmt-rfc-style);
    };
}
