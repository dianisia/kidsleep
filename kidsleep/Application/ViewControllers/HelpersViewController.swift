import UIKit
import RxCocoa
import RxSwift
import RxMusicPlayer

class HelpersViewController: UIViewController {
    @IBOutlet weak var nighLightButton: UIButton!
    @IBOutlet weak var songsLabel: UILabel!
    
    private let bag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBAction func turnOnLightTapped(_ sender: Any) {
        let nightLighViewController = NightLightViewController()
        presentPanModal(nightLighViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nighLightButton.layer.cornerRadius = 16
        var top = songsLabel.bottomAnchor
        
        let songsView = UIView(frame: .zero)
        view.addSubview(songsView)
        songsView.translatesAutoresizingMaskIntoConstraints = false
        songsView.topAnchor.constraint(equalTo: songsLabel.bottomAnchor, constant: 24).isActive = true
        songsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        songsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        songsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16).isActive = true
        
        var songViews = [CustomSongView]()
        
        let songs = [
            Song(name: "Name 1", artist: "", duration: 27201122625, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_1473200_1.mp3")),
            Song(name: "Name 2", artist: "", duration: 30956741607, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_2160166.mp3")),
            Song(name: "Name 3", artist: "", duration: 24116285485, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_4690995.mp3")),
            Song(name: "Name 4", artist: "", duration: 17133491467, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/tagmp3_9179181.mp3")),
            Song(name: "Name 5", artist: "", duration: 483345703756, sourceURL: URL(string: "https://storage.googleapis.com/great-dev/oss/musicplayer/bensound-extremeaction.mp3"))
        ]
        
        for song in songs {
            let songView = CustomSongView(frame: .zero)
            songView.configure(with: song)
            songsView.addSubview(songView)
            songView.translatesAutoresizingMaskIntoConstraints = false
            songView.topAnchor.constraint(equalTo: top, constant: 8).isActive = true
            songView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            songView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            songView.heightAnchor.constraint(equalToConstant: 63).isActive = true
            top = songView.bottomAnchor
            songViews.append(songView)
        }
        
        let items = songs.map {$0.sourceURL!}
            .map({ RxMusicPlayerItem(url: $0) })
        
        let player = RxMusicPlayer(items: items)!
        
        let actions: [SharedSequence<DriverSharingStrategy, RxMusicPlayer.Command>] = songViews.enumerated().map { (index, t) in
            t.tapGesture.rx.event.asDriver().map { _ in
                if t.isPlaying {
                    t.isPlaying = false
                    return RxMusicPlayer.Command.pause
                }
                songViews.forEach{ $0.isPlaying = false }
                t.isPlaying = true
                return RxMusicPlayer.Command.playAt(index: index)
            }
        }
        
        let cmd = Driver.merge(actions)
            .startWith(.stop)
            .debug()
        
        player.rx.currentItemRestDurationDisplay()
            .do(onNext: {value in
                songViews[player.playIndex].songDuration = value ?? ""
            })
            .drive()
            .disposed(by: bag)
        
        player.rx.currentItemRestDuration()
            .do(onNext: {value in
                let diff = Double(songs[player.playIndex].duration - (value?.value ?? 0))
                let progress = diff / Double(songs[player.playIndex].duration)
                songViews[player.playIndex].progressView.setProgress(Float(progress), animated: true)
            })
            .drive()
            .disposed(by: bag)
        
        player.run(cmd: cmd)
            .do(onNext: { status in
                UIApplication.shared.isNetworkActivityIndicatorVisible = status == .loading
            })
            .flatMap { [weak self] status -> Driver<()> in
                guard let weakSelf = self else { return .just(()) }
                
                switch status {
                case let RxMusicPlayer.Status.failed(err: err):
                    print(err)
        
                case let RxMusicPlayer.Status.critical(err: err):
                    print(err)
                
                default:
                    print(status)
                }
                return .just(())
            }
            .drive()
            .disposed(by: bag)
    }
}
