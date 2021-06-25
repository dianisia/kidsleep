import Foundation
import UIKit

@IBDesignable
class CustomSegmentControl: UISegmentedControl {
    let selectedTintColor = UIColor(rgb: 0x8000FF)
    
    override init(items: [Any]?) {
        super.init(items: items)
    }
    
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
        setup()
    }
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    private func setup() {
        frame.size.height = 60
        frame.size.width = 363
        selectedSegmentTintColor = selectedTintColor
        backgroundColor = .black
        let fontAttribute = [
            NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 16)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        setTitleTextAttributes(fontAttribute, for: .normal)
    }
}
