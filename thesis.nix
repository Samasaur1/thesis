{ rev, date, texliveFull, runCommandNoCC, ... }:

runCommandNoCC "output" {} ''
  echo "This is my thesis" > $out
  echo "It was built at ${date}" >> $out
  echo "off of commit ${rev}" >> $out
  echo "Running 'date' in the Nix build produces $(date)" >> $out
''
