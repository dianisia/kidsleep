import Foundation
import UIKit

@IBDesignable
class SongsInfoView: UICollectionViewCell {
    static let cellId = "cellSongs"
    private var songs = [Song]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with songs: [Song]) {
        self.songs = songs
        setup()
    }
    
    func setup() {
        let songsPlayerView = SongsPlayerView(songs: songs)
        addSubview(songsPlayerView)
        songsPlayerView.translatesAutoresizingMaskIntoConstraints = false
        songsPlayerView.topAnchor.constraint(equalTo: topAnchor, constant: 24).isActive = true
        songsPlayerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        songsPlayerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        songsPlayerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 16).isActive = true
    }
}
