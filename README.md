## How to build the thesis

```
nix build .#thesis
```

(aka)

```
quarto render --to pdf
```

## Future work

- Pick a style (from <https://www.zotero.org/styles>). I'm using biblatex, not citeproc, so that the bibliography can go in the right place, so that style repository may not apply.
- Automatic drop caps in main matter chapters (combo of pandoc filter and latex macro)
- Unify chapter/appendix/bibliography hrule offsets
- index
- "list of clarifications" where i list terms that have more than one name and which name I will be using throughout my thesis
- list of terms that aren't abbreviations (e.g. "dictionary" to mean list of key-value pairs)
- how to cite BEPs (ideally they show up as "BEP 0003" in the document instead of the author's last name)
- make all libraries (BencodeKit, TorrentFileKit, etc.) Nix flakes that are inputs to this flake, so that I can grab their last modification info and inject it into the document
- switch back to using pandoc's citeproc and <https://pandoc.org/MANUAL.html#placement-of-the-bibliography> to place the bibliography in the right location
- use the section symbol when referring to sections? <https://tex.stackexchange.com/questions/208933/how-to-show-symbol-when-i-refer-a-chapter>
- improve hexdump formatting
- change big number font (it doesn't match section numbers)
- improve swift syntax highlighting

## references

- https://cameronpatrick.com/post/2023/07/quarto-thesis-formatting
