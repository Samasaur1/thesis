{ pkgs, ... }:

let
  thesisClass = pkgs.callPackage ./reedthesis { };
in

pkgs.mkShell {
  packages = [
    pkgs.pandoc
    (pkgs.texliveFull.withPackages (_: [ thesisClass.tex ]))
  ];

  name = "sam's thesis shell";

  shellHook = ''
    echo "Thanks for building my thesis!"
  '';
}
