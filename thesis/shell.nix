{ pkgs, ... }:

pkgs.mkShell {
  packages = [
    pkgs.texliveFull
    pkgs.pandoc
  ];

  name = "sam's thesis shell";

  shellHook = ''
    echo "Thanks for building my thesis!"
  '';
}
