import Foundation
import UIKit


class MainChildInfoView: UICollectionViewCell {
    static let cellId = "cellMainInfo"
    @IBOutlet weak var nameTextField: CustomTextField!
    @IBOutlet weak var genderSegmentControl: CustomSegmentControl!
    @IBOutlet weak var birthdayTextField: CustomDataPicker!
    
    override func didMoveToWindow() {
        birthdayTextField.setMaximumDate(date: Date())
    }
}
