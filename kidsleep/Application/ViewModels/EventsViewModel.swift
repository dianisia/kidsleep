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
            breakfast: Driver.just(user.breakfast),
            firstDaySleep: Driver.just(user.firstDaySleep),
            dinner: Driver.just(user.dinner),
            brunch: Driver.just(user.brunch),
            secondDaySleep: Driver.just(user.secondDaySleep),
            secondBrunch: Driver.just(user.secondBrunch),
            eveningMeal: Driver.just(user.eveningMeal),
            nightSleep: Driver.just(user.nightSleep),
            nightMeal: Driver.just(user.nightMeal)
        )
    }
}
