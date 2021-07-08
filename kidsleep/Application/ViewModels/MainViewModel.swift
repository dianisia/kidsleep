import RxSwift
import RxCocoa

enum Events: String, CaseIterable {
    case breakfast = "завтрак"
    case firstDaySleep = "1-й дневной сон"
    case dinner = "обед"
    case brunch = "полдник"
    case secondDaySleep = "2-й дневной сон"
    case secondBrunch = "2-й полдник"
    case eveningMeal = "ужин"
    case nightSleep = "ночной сон"
    case nightMeal = "ночное кормление"
}

class MainViewModel {
    private var user: UserInfo
    private var events = [(Events, Int)]()
    
    init() {
        let repository = UserDefaultsRepository()
        user = repository.get()
        events = [
            (Events.breakfast, timeStringToMinutes(time: user.breakfast)),
            (Events.firstDaySleep, timeStringToMinutes(time: user.firstDaySleep)),
            (Events.dinner, timeStringToMinutes(time: user.dinner)),
            (Events.brunch, timeStringToMinutes(time: user.brunch)),
            (Events.secondDaySleep, timeStringToMinutes(time: user.secondDaySleep)),
            (Events.secondBrunch, timeStringToMinutes(time: user.secondBrunch)),
            (Events.eveningMeal, timeStringToMinutes(time: user.eveningMeal)),
            (Events.nightSleep, timeStringToMinutes(time: user.nightSleep)),
            (Events.nightMeal, timeStringToMinutes(time: user.nightMeal))
        ]
    }
    
    struct Input {
        
    }
    
    struct Output {
        let name: Driver<String>
        let age: Driver<String>
        let nextEvent: Driver<(String, Int)>
    }
    
    func transform(input: Input) -> Output {
        return Output(
            name: Driver.just(getName()),
            age: Driver.just(getAge()),
            nextEvent: Driver.just(getNextEvent())
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
        return (nextEvent.rawValue, minTime)
    }
    
}
