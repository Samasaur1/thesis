{ pkgs, ... }:

pkgs.mkShell {
  packages = [
    pkgs.texliveFull
    pkgs.pandoc
    pkgs.python3Packages.pandoc-xnos
  ];

  name = "sam's thesis shell";

  shellHook = ''
    echo "Thanks for building my thesis!"
  '';
}
