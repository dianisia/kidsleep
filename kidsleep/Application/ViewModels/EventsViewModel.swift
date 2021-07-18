import Foundation
import RxSwift
import RxCocoa

class EventsViewModel {
    private var user: UserInfo
    
    struct Input {
    }
    
    struct Output {
        let breakfast: Driver<String>
        let firstDaySleep: Driver<String>
        let dinner: Driver<String>
        let brunch: Driver<String>
        let secondDaySleep: Driver<String>
        let secondBrunch: Driver<String>
        let eveningMeal: Driver<String>
        let nightSleep: Driver<String>
        let nightMeal: Driver<String>
    }
    
    init() {
        let repository = UserDefaultsRepository()
        user = repository.get()
    }
    
    func transform() -> Output {
        return Output(
            breakfast: Driver.just(minutesToString(totalMinutes: user.breakfast)),
            firstDaySleep: Driver.just(minutesToString(totalMinutes: user.firstDaySleep)),
            dinner: Driver.just(minutesToString(totalMinutes: user.dinner)),
            brunch: Driver.just(minutesToString(totalMinutes: user.brunch)),
            secondDaySleep: Driver.just(minutesToString(totalMinutes: user.secondDaySleep)),
            secondBrunch: Driver.just(minutesToString(totalMinutes: user.secondBrunch)),
            eveningMeal: Driver.just(minutesToString(totalMinutes: user.eveningMeal)),
            nightSleep: Driver.just(minutesToString(totalMinutes: user.nightSleep)),
            nightMeal: Driver.just(minutesToString(totalMinutes: user.nightMeal))
        )
    }
}
