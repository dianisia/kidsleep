import Foundation
import UIKit

class CustomTimePicker: CustomInput {
    private var timePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: 140, height: 200))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTimePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTimePicker()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTimePicker()
    }
    
    private func setupTimePicker() {
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.addTarget(self, action: #selector(self.timeChanged), for: .allEvents)
        inputView = timePicker
        let doneButton = UIBarButtonItem.init(title: "Готово", style: .done, target: self, action: #selector(self.timePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        inputAccessoryView = toolBar
    }
    
    @objc func timePickerDone() {
        resignFirstResponder()
    }
    
    @objc func timeChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        text = "\(dateFormatter.string(from: timePicker.date))"
    }
}
