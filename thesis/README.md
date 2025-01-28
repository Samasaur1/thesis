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

## references

- https://cameronpatrick.com/post/2023/07/quarto-thesis-formatting
