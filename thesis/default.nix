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
      (pkgs.texliveBasic.withPackages (
        ps:
        builtins.attrValues {
          inherit (ps)
            palatino
            booktabs
            setspace
            lipsum
            etoolbox
            ocgx2
            media9
            fancyvrb
            ;
        }
      ))
      pkgs.pandoc
    ];

    buildPhase = ''
      DATE="$(TZ='America/Los_Angeles' ${pkgs.lib.getExe' pkgs.coreutils "date"} -d '@${toString lastModified}' +'%B %-d, %Y at %-I:%M%P (%z)')"

      readarray -d "" FILES < <(${pkgs.lib.getExe' pkgs.findutils "find"} thesis/chapters/ -name '*.md' -print0 | ${pkgs.lib.getExe' pkgs.coreutils "sort"} -z)

      mkdir $out

      pandoc \
        --defaults options.yaml \
        --metadata-file metadata.yaml \
        -M commitRev=${rev} -M commitShortRev=${shortRev} -M "commitDate=''${DATE}" \
        --template template.tex \
        "''${FILES[@]}" -o $out/thesis.pdf
    '';
  };
in
  pkgs.runCommandNoCC "thesis.pdf" { } ''
    ln -s ${thesis}/thesis.pdf $out
  ''
