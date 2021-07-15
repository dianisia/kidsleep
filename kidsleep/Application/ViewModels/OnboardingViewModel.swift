import Foundation
import RxSwift
import RxCocoa

final class OnboardingViewModel {
    private let disposeBag = DisposeBag()
    private var repository: Repository
    
    let name = BehaviorSubject<String>(value: "")
    let birthday = BehaviorSubject<String>(value: "")
    let breakfast = BehaviorSubject<String>(value: "")
    let firstDaySleep = BehaviorSubject<String>(value: "")
    let dinner = BehaviorSubject<String>(value: "")
    let brunch = BehaviorSubject<String>(value: "")
    let secondDaySleep = BehaviorSubject<String>(value: "")
    let secondBrunch = BehaviorSubject<String>(value: "")
    let eveningMeal = BehaviorSubject<String>(value: "")
    let nightSleep = BehaviorSubject<String>(value: "")
    let nightMeal = BehaviorSubject<String>(value: "")
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func save() {
        let info = UserInfo(
            name: try! name.value(),
            birthday: try! birthday.value(),
            breakfast: try! breakfast.value(),
            firstDaySleep: try! firstDaySleep.value(),
            dinner: try! dinner.value(),
            brunch: try! brunch.value(),
            secondDaySleep: try! secondDaySleep.value(),
            secondBrunch: try! secondBrunch.value(),
            eveningMeal: try! eveningMeal.value(),
            nightSleep: try! nightSleep.value(),
            nightMeal: try! nightMeal.value()
        )
        repository.save(info: info)
        OnboardingManager.shared.setOnboarded()
    }
    
}
