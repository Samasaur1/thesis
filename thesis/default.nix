{ rev, date, pandoc, getExe, runCommandNoCC, ... }:

runCommandNoCC "thesis.pdf" {} ''
  ${getExe pandoc} --defaults ${./options.yaml} --metadata-file ${./metadata.yaml} -M rev=${rev} -M date=${date} ${./chapters}/*.md -o $out
''
