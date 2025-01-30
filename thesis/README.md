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

## references

- https://cameronpatrick.com/post/2023/07/quarto-thesis-formatting
