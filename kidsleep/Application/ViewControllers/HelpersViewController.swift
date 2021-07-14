import UIKit
import RxCocoa
import RxSwift
import RxMusicPlayer

class HelpersViewController: UIViewController {
    @IBOutlet weak var nighLightButton: UIButton!
    @IBOutlet weak var songsLabel: UILabel!
    
    private let bag = DisposeBag()
    private let songsViewModel = SongsViewModel()
    
    private var songs = [Song]()
    private var songViews = [CustomSongView]()
    
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
        
        let output = songsViewModel.transform(input: SongsViewModel.Input())
        songs = output.songs
        nighLightButton.layer.cornerRadius = 16
        
        songViewsSetup()
        setupPlayer()
    }
    
    private func songViewsSetup() {
        let songsView = UIView(frame: .zero)
        view.addSubview(songsView)
        songsView.translatesAutoresizingMaskIntoConstraints = false
        songsView.topAnchor.constraint(equalTo: songsLabel.bottomAnchor, constant: 24).isActive = true
        songsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        songsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        songsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16).isActive = true
        
        var top = songsLabel.bottomAnchor
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
    }
    
    private func setupPlayer() {
        let items = songs.map {$0.sourceURL!}
            .map({ RxMusicPlayerItem(url: $0) })
        
        let player = RxMusicPlayer(items: items)!
    
        let actions: [SharedSequence<DriverSharingStrategy, RxMusicPlayer.Command>] = songViews.enumerated().map { (index, t) in
            t.tapGesture.rx.event.asDriver().map { [unowned self] _ in
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
            .startWith(.prefetch)
            .debug()
            .do(onNext: { event in
                print(event)
            })
        
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
            .flatMap { status -> Driver<()> in
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
