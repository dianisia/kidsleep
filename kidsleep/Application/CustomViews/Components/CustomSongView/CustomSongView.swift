import Foundation
import UIKit

@IBDesignable
class CustomSongView: UIView {
    @IBInspectable var songName: String = "" {
        didSet {
            songNameLabel.text = songName
        }
    }
    
    @IBInspectable var songDuration: Int = 0 {
        didSet {
            durationLabel.text = "\(songDuration) мин"
        }
    }
    
    private static let playImage = UIImage(named: "Play")
    private static let pauseImage = UIImage(named: "Pause")
    
    private var isPlaying = false {
        didSet {
            actionView.image = isPlaying ? CustomSongView.pauseImage : CustomSongView.playImage
        }
    }
    
    private let songNameLabel = UILabel(frame: CGRect(x: 65, y: 13, width: 72, height: 20))
    private let durationLabel = UILabel(frame: CGRect(x: 65, y: 33, width: 72, height: 20))
    private let actionView = UIImageView(frame: CGRect(x: 17, y: 19, width: 30, height: 30))
    
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
        addActionImage()
    }
    
    private func setup() {
        backgroundColor = UIColor(rgb: 0x191919)
        layer.cornerRadius = 16
    }
    
    private func addActionImage() {
        actionView.image = CustomSongView.playImage
        actionView.contentMode = .scaleAspectFit
        addSubview(actionView)
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
        durationLabel.textAlignment = .center
        durationLabel.sizeToFit()
        addSubview(durationLabel)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPlaying = !isPlaying
    }
    
}
