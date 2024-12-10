{
  rev,
  shortRev,
  lastModified,
  pkgs,
  ...
}:

let
  thesisClass = pkgs.callPackage ./reedthesis { };
in

pkgs.runCommandNoCC "thesis.pdf" { } ''
  export PATH="${pkgs.texliveFull.withPackages (_: [ thesisClass.tex ])}/bin:$PATH"

  DATE="$(${pkgs.lib.getExe' pkgs.coreutils "date"} -d '@${lastModified}' +'%B %-d, %Y at %-I:%M%P (%z)')"

  ${pkgs.lib.getExe pkgs.pandoc} \
    --defaults ${./options.yaml} \
    --metadata-file ${./metadata.yaml} \
    -M commitRev=${rev} -M commitShortRev=${shortRev} -M "commitDate=$DATE" \
    --template ${./reedthesis/template.tex} \
    ${./chapters}/*.md -o $out
''
