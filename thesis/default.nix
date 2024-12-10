{
  rev,
  shortRev,
  date,
  pkgs,
  ...
}:

let
  thesisClass = pkgs.callPackage ./reedthesis { };
in

pkgs.runCommandNoCC "thesis.pdf" { } ''
  export PATH="${pkgs.texliveFull.withPackages (_: [ thesisClass.tex ])}/bin:$PATH"

  ${pkgs.lib.getExe pkgs.pandoc} \
    --defaults ${./options.yaml} \
    --metadata-file ${./metadata.yaml} \
    -M commitRev=${rev} -M commitShortRev=${shortRev} -M commitDate=${date} \
    --template ${./reedthesis/template.tex} \
    ${./chapters}/*.md -o $out
''
