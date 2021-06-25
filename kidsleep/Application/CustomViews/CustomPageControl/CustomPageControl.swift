import Foundation
import UIKit

@IBDesignable
class CustomPageControl: UIPageControl {
    let pageIndicatorColor = UIColor(red: 191, green: 184, blue: 203)
    let currPageColor = UIColor(red: 74, green: 0, blue: 147)
    
    override class func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPageControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPageControl()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupPageControl()
    }
    
    private func setupPageControl() {
        pageIndicatorTintColor = pageIndicatorColor
        currentPageIndicatorTintColor = currPageColor
    }
}
