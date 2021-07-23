import RxSwift
import RxCocoa

final class MainViewModel: ViewModelType {
    private let bag = DisposeBag()
    private var user: Observable<UserInfo>
    private var events = BehaviorRelay<[(Events, Int)]>(value: [])
    private var nextEv = BehaviorRelay<(String, Int)>(value: ("", 0))
    static private let checkEventInterval = 30
    
    init(serviceProvider: ServiceProviderType) {
        user = serviceProvider.userInfoService.get()
        user.subscribe(onNext: { [unowned self] userInfo in
            let newEvents = [
                (Events.breakfast, userInfo.breakfast),
                (Events.firstDaySleep, userInfo.firstDaySleep),
                (Events.dinner, userInfo.dinner),
                (Events.brunch, userInfo.brunch),
                (Events.secondDaySleep, userInfo.secondDaySleep),
                (Events.secondBrunch, userInfo.secondBrunch),
                (Events.eveningMeal, userInfo.eveningMeal),
                (Events.nightSleep, userInfo.nightSleep),
                (Events.nightMeal, userInfo.nightMeal)
            ]
            events.accept(newEvents)
            nextEv.accept(getNextEvent(events: newEvents))
        })
        .disposed(by: bag)
    }
    
    struct Output {
        let name: Driver<String>
        let age: Driver<String>
        let nextEvent: Driver<(String, Int)>
    }
    
    func transform() -> Output {
        let name: Driver<String> = user
            .map { userInfo in
                return userInfo.name
            }
            .asDriver(onErrorJustReturn: "")
        
        let age: Driver<String> = user
            .map { userInfo in
                return Converter.convertBirthdayToAge(birthday: userInfo.birthday)
            }
            .asDriver(onErrorJustReturn: "")
        
        let scheduller = Observable<Int>.interval(.seconds(Self.checkEventInterval), scheduler: MainScheduler.instance)
        
        Observable.combineLatest(scheduller, events)
            .bind(onNext: { [unowned self] in
                nextEv.accept(getNextEvent(events: $1))
            })
            .disposed(by: bag)
                    
        return Output(
            name: name,
            age: age,
            nextEvent: nextEv.asDriver()
        )
    }
    
    private func getNextEvent(events: [(Events, Int)]) -> (String, Int) {
        let minutesInHour = 60
        let minutesInDay = 24 * minutesInHour
        let cal = Calendar.current
        let nowComponents = cal.dateComponents([Calendar.Component.hour, Calendar.Component.minute], from: Date())
        let current = Converter.timeStringToMinutes(time: "\(nowComponents.hour ?? 0):\(nowComponents.minute ?? 0)")

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
        return (nextEvent.rawValue, minTime)
    }
    
}
