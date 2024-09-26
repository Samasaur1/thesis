{ rev, texliveFull, runCommandNoCC, ... }:

runCommandNoCC "output" {} ''
  echo ${rev} > $out
''
