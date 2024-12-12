# First Semester

I spent the majority of the first semester writing code, most of which will be fundamental to code that I write in the second semester. That said, I tried (with some success) to write detailed sections on the code I was writing as I was implementing it. I did feel like I wasn't being as productive as I should have been, or at least that I haven't gotten as far as I wanted to (although those are very different standards). I also spent some time reading parts of the BitTorrent specification, but those documents are very Spartan and hard to understand without attempting to implement what they describe, which has left me not entirely grasping most of the proposals that I didn't either a) cover in my previous work on BitTorrent; or b) get to implementing this semester.

## Code

I produced two main sections of code:

- BencodeKit. This is a Swift package that allows converting between binary bencoded data and structured types. As opposed to the approach that I took in pmy previous work, this package parses bencode in a more structured fashion, which eliminates an entire class of errors (mistyped keys), as well as providing stronger typechecking, reducing boilerplate, better error handling, and more. It is entirely non-dependent on the rest of my thesis code, and is tested individually with a large number of tests. Barring any bugs I discover in the future, this part of my thesis is essentially complete.
- TorrentFileKit. This is a Swift package for parsing torrent files ("metainfo files"). Originally, the idea was that it was supposed to parse any of v1, hybrid, or v2 torrent files and unify them into one publicly-accessible type that would be consumed by the rest of my thesis. Unfortunately, this proved to be more difficult than expected, so for the time being this package is limited to v1 torrent files. The v1 functionality of this package is essentially complete, and it just needs a little more work so as to not try parsing v2 or hybrid torrent files and immediately fail.

## Writing

I produced a section on bencode alongside BencodeKit. THis section undoubtedly needs more revision, but covers the concepts of bencode fairly well. I have left a spot to go into depth on how the encoding and decoding works, but have not yet written this.

I have not yet written anything about torrent files. Version 1 torrent files are not complex at all, so this will be very little. Version 2 and hybrid torrent files are more complex, which I need to write about, and I also need to write about the attempts I made at parsing and why they failed.

# Next Semester

I have a couple things I am hoping to get to in the rest of this semester, but if I do not get to them, then they will be first on my list for next semester:

1. finish up the TorrentFileKit package. As noted above, everything is essentially already there but a little more work is needed.
1. do a writeup and post-mortem on my work on torrent files
1. begin writing the orchestrating package
1. begin talking to trackers

If I manage to complete all of the above, then my first task next semester will be to finish up tracker communication, followed by beginning peer communication.

# Goals for Content

## Core Goals

My highest-priority goals are: a) get the very basic original form of BitTorrent working (no extensions, etc.); and b) get visualization of the swarm working. These are the core of my thesis and are necessary.

## Stretch Goals

I also have a large number of stretch goals, some of which are more achievable than others.

- support version 2 and hybrid torrents. Hybrid torrents can be done without changing the peer wire protocol, but v2 torrents do change this protocol, so would be a large amount of work
- support peer exchange, DHT, etc. (methods of discovering peers via other peers). These are complicated and would be a lot of work
- better visualization/visualization of more parts of the protocol (such as visualizing a file as parts are downloaded, visualizing any extensions I implement, etc.)
- support other BitTorrent extensions. There are a large number of these and I don't know them all, so difficulty and importance varies
- provide more background knowledge in my thesis, lowering the barrier to entry. this is a very wide-ranging task, which I could also accomplish in parts.
