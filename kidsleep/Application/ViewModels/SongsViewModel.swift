import Foundation

final class SongsViewModel: ViewModelType {
    struct Output {
        let songs: [Song]
    }
    
    private let songs = [
        Song(name: "Sleep song", artist: "", duration: 27201122625, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_1473200_1.mp3")),
        Song(name: "Fairytale", artist: "", duration: 30956741607, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_2160166.mp3")),
        Song(name: "Quite sounds", artist: "", duration: 24116285485, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_4690995.mp3")),
        Song(name: "Little owl song", artist: "", duration: 17133491467, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_9179181.mp3")),
        Song(name: "Happy kitten", artist: "", duration: 483345703756, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/bensound-extremeaction.mp3"))
    ]
    
    func transform() -> Output {
        return Output(songs: songs)
    }
}
