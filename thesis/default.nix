{
  rev,
  shortRev,
  lastModified,
  pkgs,
  ...
}:

pkgs.stdenv.mkDerivation {
  pname = "thesis";
  version = "0.1.0";

  src = ./.;

  buildInputs = [
    pkgs.texliveFull
    pkgs.pandoc
  ];

  buildPhase = ''
    DATE="$(TZ='America/Los_Angeles' ${pkgs.lib.getExe' pkgs.coreutils "date"} -d '@${toString lastModified}' +'%B %-d, %Y at %-I:%M%P (%z)')"

    pandoc \
      --defaults options.yaml \
      --metadata-file metadata.yaml \
      -M commitRev=${rev} -M commitShortRev=${shortRev} -M "commitDate=$DATE" \
      --template template.tex \
      chapters/*.md -o $out
  '';
}
