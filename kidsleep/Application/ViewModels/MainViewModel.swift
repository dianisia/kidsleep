import RxSwift
import RxCocoa

final class MainViewModel: ViewModelType {
    private let bag = DisposeBag()
    private var user: UserInfo
    private var events = [(String, Int)]()
    private var nextEv = BehaviorRelay<(String, Int)>(value: ("", 0))
    static private let checkEventInterval = 30
    
    init() {
        let repository = UserDefaultsRepository()
        user = repository.get()
    }
    
    struct Output {
        let name: Driver<String>
        let age: Driver<String>
        let nextEvent: Driver<(String, Int)>
    }
    
    func transform() -> Output {
        nextEv.accept(getNextEvent())
        
        Observable<Int>.interval(.seconds(Self.checkEventInterval), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] _ in
                nextEv.accept(getNextEvent())
            })
            .disposed(by: bag)
        
        return Output(
            name: Driver.just(getName()),
            age: Driver.just(getAge()),
            nextEvent: nextEv.asDriver()
        )
    }
    
    private func getName() -> String {
        return user.name
    }
    
    private func getAge() -> String {
        let secondsInYear = Double(86400 * 365)
        let secondsInMonth = Double(86400 * 30)
        let currEpoch = NSDate().timeIntervalSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yyyy"
        let date = dateFormatter.date(from: user.birthday)?.timeIntervalSince1970 ?? 0
        let diffInSeconds = currEpoch - date
        let years = Int(diffInSeconds / secondsInYear)
        let months = Int((diffInSeconds - (Double(years) * secondsInYear)) / secondsInMonth)
        let result = formAgeString(years: years, months: months)
        return result
    }
    
    private func getNextEvent() -> (String, Int) {
        let minutesInHour = 60
        let minutesInDay = 24 * minutesInHour
        let cal = Calendar.current
        let nowComponents = cal.dateComponents([Calendar.Component.hour, Calendar.Component.minute], from: Date())
        let current =  timeStringToMinutes(time: "\(nowComponents.hour ?? 0):\(nowComponents.minute ?? 0)")
        
        var minTime = minutesInDay
        var nextEvent = events[0].0
        for event in events {
            var currMin = event.1 - current
            if (currMin < 0) {
                currMin += minutesInDay
            }
            if currMin < minTime {
                minTime = currMin
                nextEvent = event.0
            }
        }
        return (nextEvent, minTime)
    }
    
}
