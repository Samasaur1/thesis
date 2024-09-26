{
  description = "My Reed College senior thesis";

  outputs = { self, nixpkgs, ...}@inputs:
    let
      allSystems = nixpkgs.lib.systems.flakeExposed;
      forAllSystems = nixpkgs.lib.genAttrs allSystems;
      define = f: forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = {
            };
          };
        in
          f pkgs
      );
      rev = if self ? rev then
        self.rev
      else
        throw "Refusing to build from a dirty Git tree!";
    in {
      packages = define (pkgs: {
        thesis = pkgs.callPackage ./thesis.nix { inherit rev; };
      });
      
      devShells = define (pkgs: {
        default = pkgs.mkShell {
          packages = [ pkgs.texliveFull ];

          name = "sam's thesis shell";

          shellHook = ''
            echo "Thanks for building my thesis!"
          '';
        };
      });

      formatter = define (pkgs: pkgs.nixfmt-rfc-style);
    };
}
