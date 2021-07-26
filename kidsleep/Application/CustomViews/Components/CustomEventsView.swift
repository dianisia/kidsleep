import UIKit
import RxCocoa
import RxSwift

@IBDesignable
class CustomEventsView: UIView {
    private let bag = DisposeBag()

    var breakfastTimeInput: CustomTimePicker = {
        let input = CustomTimePicker()
        input.placeholder = Events.breakfast.rawValue
        input.rightImage = UIImage(named: "bottle")
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    var firstdaySleepTimeInput: CustomTimePicker = {
        let input = CustomTimePicker()
        input.placeholder = Events.firstDaySleep.rawValue
        input.rightImage = UIImage(named: "sleep")
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    var dinnerTimeInput: CustomTimePicker = {
        let input = CustomTimePicker()
        input.placeholder = Events.dinner.rawValue
        input.rightImage = UIImage(named: "bottle")
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    var brunchTimeInput: CustomTimePicker = {
        let input = CustomTimePicker()
        input.placeholder = Events.brunch.rawValue
        input.rightImage = UIImage(named: "bottle")
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    var secondDaySleepInput: CustomTimePicker = {
        let input = CustomTimePicker()
        input.placeholder = Events.secondDaySleep.rawValue
        input.rightImage = UIImage(named: "sleep")
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    var secondBrunchTimeInput: CustomTimePicker = {
        let input = CustomTimePicker()
        input.placeholder = Events.secondBrunch.rawValue
        input.rightImage = UIImage(named: "bottle")
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    var eveningMealTimeInput: CustomTimePicker = {
        let input = CustomTimePicker()
        input.placeholder = Events.eveningMeal.rawValue
        input.rightImage = UIImage(named: "bottle")
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    var nightSleepTimeInput: CustomTimePicker = {
        let input = CustomTimePicker()
        input.placeholder = Events.nightSleep.rawValue
        input.rightImage = UIImage(named: "sleep")
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    var nightMealTimeInput: CustomTimePicker = {
        let input = CustomTimePicker()
        input.placeholder = Events.nightMeal.rawValue
        input.rightImage = UIImage(named: "bottle")
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func configure(with data: EventsViewModel.Output) {
        data.breakfast.drive(breakfastTimeInput.rx.text)
            .disposed(by: bag)
        data.firstDaySleep.drive(firstdaySleepTimeInput.rx.text)
            .disposed(by: bag)
        data.brunch.drive(brunchTimeInput.rx.text)
            .disposed(by: bag)
        data.dinner.drive(dinnerTimeInput.rx.text)
            .disposed(by: bag)
        data.secondDaySleep.drive(secondDaySleepInput.rx.text)
            .disposed(by: bag)
        data.secondBrunch.drive(secondBrunchTimeInput.rx.text)
            .disposed(by: bag)
        data.eveningMeal.drive(eveningMealTimeInput.rx.text)
            .disposed(by: bag)
        data.nightSleep.drive(nightSleepTimeInput.rx.text)
            .disposed(by: bag)
        data.nightMeal.drive(nightMealTimeInput.rx.text)
            .disposed(by: bag)
    }
    
    private func setup() {
        backgroundColor = .black
        addSubview(breakfastTimeInput)
        addSubview(firstdaySleepTimeInput)
        addSubview(dinnerTimeInput)
        addSubview(brunchTimeInput)
        addSubview(secondDaySleepInput)
        addSubview(secondBrunchTimeInput)
        addSubview(eveningMealTimeInput)
        addSubview(nightSleepTimeInput)
        addSubview(nightMealTimeInput)
        setupConstraints()
    }
    
    private func setupConstraints() {
        addConstraintToElement(item: breakfastTimeInput)
        breakfastTimeInput.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true

        addConstraintToElement(item: firstdaySleepTimeInput)
        firstdaySleepTimeInput.topAnchor.constraint(equalTo: breakfastTimeInput.bottomAnchor, constant: 8).isActive = true
    
        addConstraintToElement(item: dinnerTimeInput)
        dinnerTimeInput.topAnchor.constraint(equalTo: firstdaySleepTimeInput.bottomAnchor, constant: 8).isActive = true
        
        addConstraintToElement(item: brunchTimeInput)
        brunchTimeInput.topAnchor.constraint(equalTo: dinnerTimeInput.bottomAnchor, constant: 8).isActive = true
        
        addConstraintToElement(item: secondDaySleepInput)
        secondDaySleepInput.topAnchor.constraint(equalTo: brunchTimeInput.bottomAnchor, constant: 8).isActive = true
        
        addConstraintToElement(item: secondBrunchTimeInput)
        secondBrunchTimeInput.topAnchor.constraint(equalTo: secondDaySleepInput.bottomAnchor, constant: 8).isActive = true
        
        addConstraintToElement(item: eveningMealTimeInput)
        eveningMealTimeInput.topAnchor.constraint(equalTo: secondBrunchTimeInput.bottomAnchor, constant: 8).isActive = true
        
        addConstraintToElement(item: nightSleepTimeInput)
        nightSleepTimeInput.topAnchor.constraint(equalTo: eveningMealTimeInput.bottomAnchor, constant: 8).isActive = true
        
        addConstraintToElement(item: nightMealTimeInput)
        nightMealTimeInput.topAnchor.constraint(equalTo: nightSleepTimeInput.bottomAnchor, constant: 8).isActive = true
    }
    
    private func addConstraintToElement(item: UIView) {
        item.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        item.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        item.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
}
