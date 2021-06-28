import Foundation
import UIKit

class CustomDataPicker: CustomInput {
    private var datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: 140, height: 200))
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDataPicker()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDataPicker()
    }
    
    override func layoutSubviews() {
        setupDataPicker()
    }
    
    private func setupDataPicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        inputView = datePicker
        let doneButton = UIBarButtonItem.init(title: "Готово", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        inputAccessoryView = toolBar
    }
    
    @objc func datePickerDone() {
        resignFirstResponder()
    }
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        text = "\(dateFormatter.string(from: datePicker.date))"
    }
    
}
