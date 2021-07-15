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
        setupSongsPlayer()
    }
    
    private func setupSongsPlayer() {
        let songsPlayerView = SongsPlayerView(songs: songs)
        view.addSubview(songsPlayerView)
        songsPlayerView.translatesAutoresizingMaskIntoConstraints = false
        songsPlayerView.topAnchor.constraint(equalTo: songsLabel.bottomAnchor, constant: 24).isActive = true
        songsPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        songsPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        songsPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16).isActive = true
    }
    
}
