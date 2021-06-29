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
    
    private var songNameLabel = UILabel(frame: CGRect(x: 65, y: 13, width: 72, height: 20))
    private var durationLabel = UILabel(frame: CGRect(x: 65, y: 33, width: 72, height: 20))
    
    private var songNameFont = UIFont(name: "Montserrat-Bold", size: 16)!
    private var durationFont = UIFont(name: "Montserrat-Medium", size: 14)!
    
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
    }
    
    private func setup() {
        backgroundColor = UIColor(rgb: 0x191919)
        layer.cornerRadius = 16
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
    
}
