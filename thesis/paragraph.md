### Direct downloading (client-server model)
The typical way that a file is downloaded is called "direct downloading". In this process, the downloader (a "client") connects to the computer which has the file (the "server"). Once the connection is open and handshakes have been made, the server starts reading the file from its own disk and writing it to the network. As the client receives this data, it writes it to its own disk.

### Downloading with BitTorrent (peer-to-peer)
BitTorrent is a peer-to-peer file-sharing protocol. What this means is that rather than having all downloaders download from a central server, they download from each other. In this process, the downloader acquires a "torrent file"/"metainfo file" that describes the file they actually want to download. (Typically this happens by directly downloading the torrent file from torrent sites, but it doesn't matter). When the downloader opens the torrent file, they become a "peer". They connect to a "tracker" server listed in the torrent file, which tells them the addresses of other peers in the "swarm" (the network of peers downloading the same file). Then they connect to some of those peers, from whom they will download pieces of the file. As they receive pieces of the file from peers, they inform other peers of the newly received pieces. From that point on, the other peers can request pieces from the downloader, who uploads them in response. (All communication between peers is defined by the "peer wire protocol"). Once the downloader has downloaded all the pieces of the desired file, they may close their BitTorrent client and leave the swarm, or they can remain as a "seeder" to share the file with others


### notes
- downloader should be replaced with client to avoid "the downloader uploads them in response"
- relationship between files and data (esp. first paragraph)
    - breaking files up into pieces
- "X is a downloader" vs "X is a peer"
- application itself vs machine it is running on vs person using machine
- say explicitly that traditionally we say client-server because the protocols are asymmetric, but in bittorrent/any peer-to-peer implementation you act as both roles
