import Foundation
import UIKit

@IBDesignable
class ScheduleInfoView: UICollectionViewCell {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var breakfast: CustomTimePicker!
    @IBOutlet weak var firstDaySleep: CustomTimePicker!
    @IBOutlet weak var dinner: CustomTimePicker!
    @IBOutlet weak var brunch: CustomTimePicker!
    @IBOutlet weak var secondDaySleep: CustomTimePicker!
    @IBOutlet weak var secondBrunch: CustomTimePicker!
    @IBOutlet weak var eveningMeal: CustomTimePicker!
    @IBOutlet weak var nightSleep: CustomTimePicker!
    @IBOutlet weak var nightMeal: CustomTimePicker!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func instantiate() {
        breakfast.text = "7:00"
        firstDaySleep.text = "9:00"
        dinner.text = "11:30"
        brunch.text = "13:30"
        secondDaySleep.text = "14:00"
        secondBrunch.text = "16:00"
        eveningMeal.text = "19:00"
        nightSleep.text = "21:00"
        nightMeal.text = "24:00"
    }

}
