{
  rev,
  shortRev,
  lastModified,
  pkgs,
  ...
}:

let
  thesis = pkgs.stdenv.mkDerivation {
    pname = "thesis";
    version = "0.1.0";

    src = ./.;

    buildInputs = [
      (pkgs.texliveBasic.withPackages (ps: builtins.attrValues { inherit (ps) palatino booktabs setspace; }))
      pkgs.pandoc
    ];

    buildPhase = ''
      DATE="$(TZ='America/Los_Angeles' ${pkgs.lib.getExe' pkgs.coreutils "date"} -d '@${toString lastModified}' +'%B %-d, %Y at %-I:%M%P (%z)')"

      mkdir $out

      pandoc \
        --defaults options.yaml \
        --metadata-file metadata.yaml \
        -M commitRev=${rev} -M commitShortRev=${shortRev} -M "commitDate=$DATE" \
        --template template.tex \
        chapters/*.md -o $out/thesis.pdf
    '';
  };
in
  pkgs.runCommandNoCC "thesis.pdf" { } ''
    ln -s ${thesis}/thesis.pdf $out
  ''
