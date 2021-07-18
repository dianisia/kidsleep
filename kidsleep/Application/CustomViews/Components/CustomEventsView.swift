import UIKit
import RxCocoa
import RxSwift

@IBDesignable
class CustomEventsView: UIView {
    private let bag = DisposeBag()
    private var peekeers = [CustomTimePicker]()
    private var events = [EventInput]()
   
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
    
    func configure(with events: [EventInput]) {
        self.events = events
    }
    
    private func setup() {
        backgroundColor = .black
        setupPeekers()
    }
    
    private func setupPeekers() {
        var top = topAnchor
        for event in events {
            let peeker = CustomTimePicker()
            if (event.type != nil) {
                peeker.rightImage = getPeekerRightImage(type: event.type!)
            }
            peeker.translatesAutoresizingMaskIntoConstraints = false
            addSubview(peeker)
            peeker.topAnchor.constraint(equalTo: top, constant: 8).isActive = true
            peeker.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
            peeker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
            peeker.heightAnchor.constraint(equalToConstant: 56).isActive = true
            top = peeker.bottomAnchor
        }
    }
    
    private func getPeekerRightImage(type: EventType) -> UIImage {
        switch type {
        case .food:
            return UIImage(named: "food")!
        case .sleep:
            return UIImage(named: "sleep")!
        }
    }
}
