import Foundation

class Song {
    let title: String
    let artist: String
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
}

protocol Iterator {
    func hasNext() -> Bool
    func next() -> Song?
}

protocol Playlist {
    func createIterator() -> Iterator
    func addSong(song: Song)
}

class PlaylistIterator: Iterator {
    private let songs: [Song]
    private var currentIndex: Int = 0
    
    init(songs: [Song]) {
        self.songs = songs
    }
    
    func hasNext() -> Bool {
        return currentIndex < songs.count
    }
    
    func next() -> Song? {
        guard hasNext() else { return nil }
        let song = songs[currentIndex]
        currentIndex += 1
        return song
    }
}

class PlaylistImpl: Playlist {
    private var songs: [Song] = []
    
    func createIterator() -> Iterator {
        return PlaylistIterator(songs: songs)
    }
    
    func addSong(song: Song) {
        songs.append(song)
    }
}

let playlist = PlaylistImpl()
playlist.addSong(song: Song(title: "Song 1", artist: "Artist 1"))
playlist.addSong(song: Song(title: "Song 2", artist: "Artist 2"))
playlist.addSong(song: Song(title: "Song 3", artist: "Artist 3"))

let iterator = playlist.createIterator()
print("Iterating through the playlist:")
while iterator.hasNext() {
    if let song = iterator.next() {
        print("Title: \(song.title), Artist: \(song.artist)")
    }
}

