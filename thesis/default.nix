{ rev, date, pandoc, texliveFull, getExe, runCommandNoCC, ... }:

runCommandNoCC "thesis.pdf" {} ''
  export PATH="${texliveFull}/bin:$PATH"

  ${getExe pandoc} \
    --defaults ${./options.yaml} \
    --metadata-file ${./metadata.yaml} \
    -M rev=${rev} -M date=${date} \
    --template ${./reedthesis/template.tex} \
    ${./chapters}/*.md -o $out
''
