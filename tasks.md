2024-11-15:
- 1-2 hours trying to get torrent fiel v2 parsing working
- torrent file parsing tests
- writing about torrent files
- find a design pattern for the structure of the control program
- (maybe) start writing the control program

2024-11-22:
- READMEs for bencode and torrentfiles
- more tests for both
- writing abobut both
- rework bencode to throw errors instead of crashing
- calculate infohashes when parsing torrentfiles
- "solve" failing torrentfile tests
    - i can't just read the infohash on parse, because by definition of a hash function it's one way

2024-12-05:
- finish parsing torrentfiles (v1 only)
- (very minimal) post-mortem of v2/hybrid
- looking towards architecture/multiple torrents
- start talking to trackers
- writeup of torrentfiles
