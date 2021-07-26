import Foundation
import RxSwift
import RxCocoa

extension EventsViewModel {
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
}

final class EventsViewModel {
    private let disposeBag = DisposeBag()
    private var user: Observable<UserInfo>
    private var serviceProvider: ServiceProviderType
    
    init(serviceProvider: ServiceProviderType) {
        self.serviceProvider = serviceProvider
        user = serviceProvider.userInfoService.get()
    }
    
    func transform() -> Output {
        let breakfast: Driver<String> = user
            .map { Converter.minutesToString($0.breakfast) }
            .asDriver(onErrorJustReturn: "00:00")
        let firstDaySleep: Driver<String> = user
            .map { Converter.minutesToString($0.firstDaySleep) }
            .asDriver(onErrorJustReturn: "00:00")
        let dinner: Driver<String> = user
            .map { Converter.minutesToString($0.dinner) }
            .asDriver(onErrorJustReturn: "00:00")
        let brunch: Driver<String> = user
            .map { Converter.minutesToString($0.brunch) }
            .asDriver(onErrorJustReturn: "00:00")
        let secondDaySleep: Driver<String> = user
            .map { Converter.minutesToString($0.secondDaySleep) }
            .asDriver(onErrorJustReturn: "00:00")
        let secondBrunch: Driver<String> = user
            .map { Converter.minutesToString($0.secondBrunch) }
            .asDriver(onErrorJustReturn: "00:00")
        let eveningMeal: Driver<String> = user
            .map { Converter.minutesToString($0.eveningMeal) }
            .asDriver(onErrorJustReturn: "00:00")
        let nightSleep: Driver<String> = user
            .map { Converter.minutesToString($0.nightSleep) }
            .asDriver(onErrorJustReturn: "00:00")
        let nightMeal: Driver<String> = user
            .map { Converter.minutesToString($0.nightMeal) }
            .asDriver(onErrorJustReturn: "00:00")
        
        return Output(
            breakfast: breakfast,
            firstDaySleep: firstDaySleep,
            dinner: dinner,
            brunch: brunch,
            secondDaySleep: secondDaySleep,
            secondBrunch: secondBrunch,
            eveningMeal: eveningMeal,
            nightSleep: nightSleep,
            nightMeal: nightMeal
        )
    }
}
