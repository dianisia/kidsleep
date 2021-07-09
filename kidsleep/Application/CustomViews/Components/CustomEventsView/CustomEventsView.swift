import UIKit

@IBDesignable
class CustomEventsView: UIView {
    
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
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
       
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 650).isActive = true
    }
    
    private func setup() {
        contentView.addSubview(breakfastTimeInput)
        contentView.addSubview(firstdaySleepTimeInput)
        contentView.addSubview(dinnerTimeInput)
        contentView.addSubview(brunchTimeInput)
        contentView.addSubview(secondDaySleepInput)
        contentView.addSubview(secondBrunchTimeInput)
        contentView.addSubview(eveningMealTimeInput)
        contentView.addSubview(nightSleepTimeInput)
        contentView.addSubview(nightMealTimeInput)
        
        addConstraintToElement(item: breakfastTimeInput)
        breakfastTimeInput.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true

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
        item.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        item.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        item.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
}
