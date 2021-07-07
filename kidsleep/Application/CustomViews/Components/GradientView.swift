import Foundation

import UIKit

@IBDesignable
class GradientView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let colors = [
            UIColor(red: 0.4, green: 0.204, blue: 0.961, alpha: 1),
            UIColor(red: 0.051, green: 0.051, blue: 0.051, alpha: 1)
        ]
        let startPoint = CGPoint(x: 0.5, y: 0.0)
        let endPoint = CGPoint(x: 0.5, y: 0.5)
        let locations: [NSNumber] = [0.2, 0.8]
        
        applyGradient(
            colors: colors,
            startPoint: startPoint,
            endPoint: endPoint,
            locations: locations
        )
    }
}
