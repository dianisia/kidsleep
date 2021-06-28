import Foundation
import UIKit

@IBDesignable
class CustomSegmentControl: UISegmentedControl {
    private let selectedTintColor = UIColor(rgb: 0x8000FF)
    private let fontAttribute = [
        NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 16)!,
        NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    
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
        selectedSegmentTintColor = selectedTintColor
        backgroundColor = .black
        setTitleTextAttributes(fontAttribute, for: .normal)
    }
}
