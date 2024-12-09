{ rev, shortRev, date, pkgs, ... }:

let
  thesisClass = pkgs.callPackage ./reedthesis {};
in

pkgs.runCommandNoCC "thesis.pdf" {} ''
  export PATH="${pkgs.texliveFull.withPackages (_: [ thesisClass.tex ])}/bin:$PATH"

  ${pkgs.lib.getExe pkgs.pandoc} \
    --defaults ${./options.yaml} \
    --metadata-file ${./metadata.yaml} \
    -M rev=${rev} -M shortRev=${shortRev} -M date=${date} \
    --template ${./reedthesis/template.tex} \
    --lua-filter ${./reedthesis/meta-vars.lua} \
    ${./chapters}/*.md -o $out
''
