import UIKit
import RxCocoa
import RxSwift

@IBDesignable
class MainChildCard: UIView {
    var eventType = "Event" {
        didSet {
            infoLabel.text = makeEventInfoString(event: eventType)
        }
    }
    
    var minutesToNextEvent: Int = 0 {
        didSet {
            eventTimeLabel.text = makeNextEventTimeString(minutes: minutesToNextEvent)
        }
    }
    
    private let nameLabelFont = UIFont(name: "Montserrat-SemiBold", size: 18)!
    private let labelFont = UIFont(name: "Montserrat-SemiBold", size: 16)!
    private let eventTimeFont = UIFont(name: "Montserrat-SemiBold", size: 22)!
    
    private var stackView = UIStackView()
    
    private var imageView = UIImageView()
    var nameLabel = UILabel()
    var ageLabel = UILabel()
    var infoLabel = UILabel()
    private var eventTimeLabel = UILabel()
    
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
    }
    
    private func setup() {
        backgroundColor = .black
        layer.cornerRadius = 50
        layer.borderColor = UIColor(rgb: 0x242424).cgColor
        layer.borderWidth = 2
        
        let stackView = UIStackView(frame: CGRect(x: 93, y: 83, width: 290, height: 32))
        stackView.spacing = 15.0
        stackView.center.x = bounds.size.width / 2.0
        
        let image = UIImage(named: "child")
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 89, height: 22))
        nameLabel.font = nameLabelFont
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.sizeToFit()
        
        ageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 89, height: 22))
        ageLabel.font = labelFont
        ageLabel.textColor = .lightGray
        ageLabel.textAlignment = .center
        ageLabel.sizeToFit()
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(ageLabel)
        addSubview(stackView)
        
        infoLabel = UILabel(frame: CGRect(x: 0, y: stackView.frame.maxY + 23, width: bounds.size.width, height: 22))
        infoLabel.font = labelFont
        infoLabel.textColor = UIColor.white
        infoLabel.textAlignment = .center
        infoLabel.center.x = bounds.size.width / 2.0
        addSubview(infoLabel)
        
        eventTimeLabel = UILabel(frame: CGRect(x: 0, y: infoLabel.frame.maxY + 5, width: 189, height: 22))
        eventTimeLabel.font = eventTimeFont
        eventTimeLabel.textColor = .white
        eventTimeLabel.textAlignment = .center
        eventTimeLabel.center.x = bounds.size.width / 2.0
        addSubview(eventTimeLabel)
        
        let button = CustomButton(frame: CGRect(x: 0, y: eventTimeLabel.frame.maxY + 24, width: 225, height: 56))
        button.setTitle("Добавить событие", for: .normal)
        button.center.x = bounds.size.width / 2.0
        addSubview(button)
    }
    
    private func makeEventInfoString(event: String) -> String {
        return "По графику дня, \(event) через"
    }
    
    private func makeNextEventTimeString(minutes: Int) -> String {
        let minutesInHour = 60
        let hours = Int(minutes / minutesInHour)
        let minutes = minutes - hours * minutesInHour
        return formTimeString(hours: hours, minutes: minutes)
    }
}
