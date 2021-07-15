import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxMusicPlayer

class SongsPlayerView: UIView {
    private var songs = [Song]()
    private var songViews = [CustomSongView]()
    
    private let bag = DisposeBag()
    
    required init(songs: [Song]) {
        super.init(frame: .zero)
        setup(with: songs)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(with songs: [Song]) {
        self.songs = songs
        songViewsSetup()
        setupPlayer()
    }
    
    private func songViewsSetup() {
        var top = topAnchor
        for song in songs {
            let songView = CustomSongView(frame: .zero)
            songView.configure(with: song)
            addSubview(songView)
            songView.translatesAutoresizingMaskIntoConstraints = false
            songView.topAnchor.constraint(equalTo: top, constant: 8).isActive = true
            songView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
            songView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
            songView.heightAnchor.constraint(equalToConstant: 63).isActive = true
            top = songView.bottomAnchor
            songViews.append(songView)
        }
    }
    
    private func setupPlayer() {
        let items = songs.map {$0.sourceURL!}
            .map({ RxMusicPlayerItem(url: $0) })
        
        let player = RxMusicPlayer(items: items)!
        
        let actions: [SharedSequence<DriverSharingStrategy, RxMusicPlayer.Command>] = songViews.enumerated().map { (index, t) in
            t.tapGesture.rx.event.asDriver().map { _ in
                if t.isPlaying {
                    t.isPlaying = false
                    return RxMusicPlayer.Command.pause
                }
                return RxMusicPlayer.Command.playAt(index: index)
            }
        }
    
        let cmd = Driver.merge(actions)
            .startWith(.prefetch)

        player.rx.currentItemRestDurationDisplay()
            .do(onNext: { [unowned self] value in
                songViews[player.playIndex].songDuration = value ?? ""
            })
            .drive()
            .disposed(by: bag)
        
        player.rx.currentItemTime()
            .do(onNext: { [unowned self] value in
                let diff = Double(songs[player.playIndex].duration - (songs[player.playIndex].duration - (value?.value ?? 0)))
                let progress = diff / Double(songs[player.playIndex].duration)
                songViews[player.playIndex].progressView.setProgress(Float(progress), animated: true)
            })
            .drive()
            .disposed(by: bag)
                
        player.run(cmd: cmd)
            .flatMap { [unowned self] status -> Driver<()> in
                switch status {
                case let RxMusicPlayer.Status.failed(err: err):
                    print(err)
                case let RxMusicPlayer.Status.critical(err: err):
                    print(err)
                case RxMusicPlayer.Status.playing:
                    songViews.forEach{ $0.isPlaying = false }
                    songViews[player.playIndex].isPlaying = true
                default:
                    print(status)
                }
                return .just(())
            }
            .drive()
            .disposed(by: bag)
    }
}
