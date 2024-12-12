## How to build the thesis

```
nix build .#thesis
```

## Future work

- Getting something akin to <https://github.com/tomduck/pandoc-xnos> set up. Unfortunately, that filter only supports Pandoc 2 and below (even if you adjust the regex)
- Pick a style (from <https://www.zotero.org/styles>)
- Automatic drop caps in main matter chapters (combo of pandoc filter and latex macro)
