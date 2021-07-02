import Foundation
import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension UIView {
    @discardableResult
    func applyGradient(colors: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colors: colors, startPoint: nil, endPoint: nil, locations: nil)
    }

    @discardableResult
    func applyGradient(colors: [UIColor], startPoint: CGPoint?, endPoint: CGPoint?, locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        if let sp = startPoint {
            gradient.startPoint = sp
        }
        if let ep = endPoint {
            gradient.endPoint = ep
        }
        gradient.cornerRadius = self.layer.cornerRadius
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}


