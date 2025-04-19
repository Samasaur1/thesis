{ pkgs, ... }:

pkgs.mkShell {
  packages = [
    pkgs.texliveFull
    pkgs.quarto
  ];

  name = "sam's thesis shell";

  shellHook = ''
    echo "Thanks for building my thesis!"
  '';
}
