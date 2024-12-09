{ rev, date, pandoc, texliveFull, getExe, runCommandNoCC, stdenvNoCC, writeShellScript, ... }:

let
  thesisClass = stdenvNoCC.mkDerivation {
    pname = "reedthesis";
    version = "1.0.0";

    outputs = [ "tex" ];

    src = ./reedthesis.cls;

    nativeBuildInputs = [
      (writeShellScript "force-tex-output.sh" ''
       out="''${tex-}"
       '')
    ];

    installPhase = ''
      runHook preInstall

      path="$tex/tex/latex/reedthesis"

      mkdir -p "$path"

      cp reedthesis.cls "$path/"

      runHook postInstall
    '';
  };
in

runCommandNoCC "thesis.pdf" {} ''
  export PATH="${texliveFull.withPackages (_: [ thesisClass ])}/bin:$PATH"

  ${getExe pandoc} \
    --defaults ${./options.yaml} \
    --metadata-file ${./metadata.yaml} \
    -M rev=${rev} -M date=${date} \
    --template ${./reedthesis/template.tex} \
    ${./chapters}/*.md -o $out
''
