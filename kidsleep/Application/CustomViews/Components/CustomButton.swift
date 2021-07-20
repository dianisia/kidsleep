import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var text: String = "" {
        didSet {
            setTitle(text, for: .normal)
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 17)
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .disabled)
        layer.cornerRadius = 25
        setupGradient()
        setupShadow()
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor(rgb: 0x4A0094).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 1
        layer.shadowRadius = 8.0
        layer.masksToBounds = false
    }
    
    private func setupGradient() {
        applyGradient(
            colors: [UIColor(rgb: 0x4A0094), UIColor(rgb: 0x8000FF)],
            startPoint: CGPoint(x: 0.0, y: 0.5),
            endPoint: CGPoint(x: 1.0, y: 0.5),
            locations: [0.0, 0.9]
        )
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
}
