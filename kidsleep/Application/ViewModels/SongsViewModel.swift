import Foundation

final class SongsViewModel: ViewModelType {
    struct Output {
        let songs: [Song]
    }
    
    private let songs = [
        Song(name: "Name 1", artist: "", duration: 27201122625, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_1473200_1.mp3")),
        Song(name: "Name 2", artist: "", duration: 30956741607, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_2160166.mp3")),
        Song(name: "Name 3", artist: "", duration: 24116285485, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_4690995.mp3")),
        Song(name: "Name 4", artist: "", duration: 17133491467, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_9179181.mp3")),
        Song(name: "Name 5", artist: "", duration: 483345703756, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/bensound-extremeaction.mp3"))
    ]
    
    func transform() -> Output {
        return Output(songs: songs)
    }
}
