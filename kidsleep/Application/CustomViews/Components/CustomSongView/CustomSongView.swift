import Foundation
import UIKit

@IBDesignable
class CustomSongView: UIView {
    @IBInspectable var songName: String = "" {
        didSet {
            songNameLabel.text = songName
        }
    }
    
    @IBInspectable var songDuration: String = ":" {
        didSet {
            durationLabel.text = "\(songDuration) мин"
        }
    }
    
    private static let playImage = UIImage(named: "Play")
    private static let pauseImage = UIImage(named: "Pause")
    
    var isPlaying = false {
        didSet {
            actionButton.setImage(isPlaying ? CustomSongView.pauseImage : CustomSongView.playImage, for: .normal)
        }
    }
    
    let progressView: UIProgressView = {
        let pv = UIProgressView()
        pv.tintColor = UIColor(rgb: 0x341256)
        return pv
    }()
    
    private let songNameLabel = UILabel(frame: CGRect(x: 65, y: 13, width: 72, height: 20))
    let durationLabel = UILabel(frame: CGRect(x: 65, y: 33, width: 72, height: 20))
    let actionButton = UIButton(frame: CGRect(x: 17, y: 19, width: 30, height: 30))
    var tapGesture = UITapGestureRecognizer()
    
    private let songNameFont = UIFont(name: "Montserrat-Bold", size: 16)!
    private let durationFont = UIFont(name: "Montserrat-Medium", size: 14)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSongNameLabel()
        addDurationLabel()
        addActionButton()
        progressView.frame = CGRect(x: 7, y: frame.height - 5, width: frame.width - 14, height: 10)
        progressView.progress = 0.0
        addSubview(progressView)
    }
    
    private func setup() {
        addGestureRecognizer(tapGesture)
        backgroundColor = UIColor(rgb: 0x191919)
        layer.cornerRadius = 16
    }
    
    private func addActionButton() {
        actionButton.setImage(CustomSongView.playImage, for: .normal)
        actionButton.isUserInteractionEnabled = false
        addSubview(actionButton)
    }
    
    private func addSongNameLabel() {
        songNameLabel.font = songNameFont
        songNameLabel.textColor = .lightGray
        songNameLabel.textAlignment = .center
        songNameLabel.sizeToFit()
        addSubview(songNameLabel)
    }
    
    private func addDurationLabel() {
        durationLabel.font = durationFont
        durationLabel.textColor = .lightGray
        durationLabel.textAlignment = .left
        addSubview(durationLabel)
    }
    
    func configure(with song: Song) {
        songName = song.name
        songDuration = formateSongDuration(duration: song.duration)
    }
    
    private func formateSongDuration(duration: Int64) -> String {
        let temp = Int(duration / 1_000_000_000)
        return "\(temp / 100):\(temp % 100)"
    }
}
