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
      # (pkgs.texliveBasic.withPackages (
      #   ps:
      #   builtins.attrValues {
      #     inherit (ps)
      #       palatino
      #       booktabs
      #       setspace
      #       lipsum
      #       etoolbox
      #       ocgx2
      #       media9
      #       fancyvrb
      #       ;
      #   }
      # ))
      pkgs.texliveFull
      pkgs.pandoc
    ];

    buildPhase = ''
      DATE="$(TZ='America/Los_Angeles' ${pkgs.lib.getExe' pkgs.coreutils "date"} -d '@${toString lastModified}' +'%B %-d, %Y at %-I:%M%P (%z)')"

      echo "Calculated last commit date of flake as $DATE"

      readarray -d "" FILES < <(${pkgs.lib.getExe' pkgs.findutils "find"} chapters/ -name '*.md' -print0 | ${pkgs.lib.getExe' pkgs.coreutils "sort"} -z)

      echo "Detected ''${#FILES[@]} Markdown files"

      mkdir $out

      echo "Created output directory"

      for f in {acknowledgements,preface,abstract,dedication}; do
        pandoc \
          --defaults common-options.yaml \
          --defaults prelim-options.yaml \
          --metadata-file metadata.yaml \
          -M commitRev=${rev} -M commitShortRev=${shortRev} -M "commitDate=''${DATE}" \
          "$f.md" -o "$f.tex"
      done

      echo "Generated prelim .tex files with Pandoc"

      pandoc \
        --defaults common-options.yaml \
        --defaults final-options.yaml \
        --metadata-file metadata.yaml \
        -M commitRev=${rev} -M commitShortRev=${shortRev} -M "commitDate=''${DATE}" \
        --template template.tex \
        "''${FILES[@]}" -o $out/thesis.pdf

      echo "Generated thesis.pdf with Pandoc"
    '';
  };
in
  pkgs.runCommandNoCC "thesis.pdf" { } ''
    ln -s ${thesis}/thesis.pdf $out
  ''
