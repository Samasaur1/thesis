{ rev, shortRev, date, pandoc, texliveFull, getExe, runCommandNoCC, stdenvNoCC, writeShellScript, ... }:

let
  thesisClass = stdenvNoCC.mkDerivation {
    pname = "reedthesis";
    version = "1.0.0";

    src = ./reedthesis/reedthesis.cls;

    outputs = [ "tex" ];

    nativeBuildInputs = [
      (writeShellScript "force-tex-output.sh" ''
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
  };
in

runCommandNoCC "thesis.pdf" {} ''
  export PATH="${texliveFull.withPackages (_: [ thesisClass.tex ])}/bin:$PATH"

  ${getExe pandoc} \
    --defaults ${./options.yaml} \
    --metadata-file ${./metadata.yaml} \
    -M rev=${rev} -M shortRev=${shortRev} -M date=${date} \
    --template ${./reedthesis/template.tex} \
    --lua-filter=${./reedthesis/meta-vars.lua} \
    ${./chapters}/*.md -o $out
''
