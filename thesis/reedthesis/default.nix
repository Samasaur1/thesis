{ pkgs, ... }:

pkgs.stdenvNoCC.mkDerivation {
  pname = "reedthesis";
  version = "1.0.0";

  src = ./reedthesis/reedthesis.cls;

  outputs = [ "tex" ];

  nativeBuildInputs = [
    (pkgs.writeShellScript "force-tex-output.sh" ''
     out="''${tex-}"
     '')
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    path="$tex/tex/latex/reedthesis"

    mkdir -p "$path"

    cp "$src" "$path/reedthesis.cls"

    runHook postInstall
  '';
}
