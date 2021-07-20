import Foundation
import RxSwift
import RxCocoa

final class EventsViewModel: ViewModelType {
    private var user: UserInfo
    
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
            breakfast: Driver.just(Converter.minutesToString(totalMinutes: user.breakfast)),
            firstDaySleep: Driver.just(Converter.minutesToString(totalMinutes: user.firstDaySleep)),
            dinner: Driver.just(Converter.minutesToString(totalMinutes: user.dinner)),
            brunch: Driver.just(Converter.minutesToString(totalMinutes: user.brunch)),
            secondDaySleep: Driver.just(Converter.minutesToString(totalMinutes: user.secondDaySleep)),
            secondBrunch: Driver.just(Converter.minutesToString(totalMinutes: user.secondBrunch)),
            eveningMeal: Driver.just(Converter.minutesToString(totalMinutes: user.eveningMeal)),
            nightSleep: Driver.just(Converter.minutesToString(totalMinutes: user.nightSleep)),
            nightMeal: Driver.just(Converter.minutesToString(totalMinutes: user.nightMeal))
        )
    }
}
