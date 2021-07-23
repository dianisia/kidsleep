import Foundation
import RxSwift
import RxCocoa

final class OnboardingViewModel {
    private let titles = Constants.onboardingTexts
    
    private let disposeBag = DisposeBag()
    private var repository: Repository

    let name = BehaviorSubject<String>(value: "")
    let birthday = BehaviorSubject<String>(value: "")
    let gender = BehaviorSubject<Int>(value: 0)
    let breakfast = BehaviorSubject<String>(value: "")
    let firstDaySleep = BehaviorSubject<String>(value: "")
    let dinner = BehaviorSubject<String>(value: "")
    let brunch = BehaviorSubject<String>(value: "")
    let secondDaySleep = BehaviorSubject<String>(value: "")
    let secondBrunch = BehaviorSubject<String>(value: "")
    let eveningMeal = BehaviorSubject<String>(value: "")
    let nightSleep = BehaviorSubject<String>(value: "")
    let nightMeal = BehaviorSubject<String>(value: "")
    
    let currentPage = BehaviorRelay<Int>(value: 0)
    let pageTitle = BehaviorRelay<String>(value: "")
    var isNextButtonEnabled: Observable<Bool>
    let isFinished = BehaviorRelay<Bool>(value: false)
    
    lazy var buttonTitle = currentPage.map({ $0 == 2 ? "Начать" : "Продолжить" })
    
    init(repository: Repository) {
        self.repository = repository
        isNextButtonEnabled = Observable.combineLatest(name, birthday) {
            return !$0.isEmpty && !$1.isEmpty
        }
        
        currentPage
            .map({[unowned self] in self.titles[$0]})
            .bind(to: pageTitle)
            .disposed(by: disposeBag)
    }
    
    private func openMain() {
        let storyboard = UIStoryboard(name: "App", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        vc.modalPresentationStyle = .overCurrentContext
        UIApplication.shared.windows[0].rootViewController = vc
    }
    
    func finishOnboarding() {
        let info = UserInfo(
            name: try! name.value(),
            birthday: try! birthday.value(),
            gender: try! gender.value(),
            breakfast: Converter.timeStringToMinutes(time: try! breakfast.value()),
            firstDaySleep: Converter.timeStringToMinutes(time: try! firstDaySleep.value()),
            dinner:  Converter.timeStringToMinutes(time: try! dinner.value()),
            brunch: Converter.timeStringToMinutes(time: try! brunch.value()),
            secondDaySleep: Converter.timeStringToMinutes(time: try! secondDaySleep.value()),
            secondBrunch: Converter.timeStringToMinutes(time: try! secondBrunch.value()),
            eveningMeal: Converter.timeStringToMinutes(time: try! eveningMeal.value()),
            nightSleep: Converter.timeStringToMinutes(time: try! nightSleep.value()),
            nightMeal: Converter.timeStringToMinutes(time: try! nightMeal.value())
        )
        repository.save(info: info)
        OnboardingManager.shared.setOnboarded()
        NotificationManager.shared.requestAuthorization() { granted in
            self.setReminder(event: Events.breakfast, minutes: info.breakfast)
            self.setReminder(event: Events.firstDaySleep, minutes: info.firstDaySleep)
            self.setReminder(event: Events.dinner, minutes: info.dinner)
            self.setReminder(event: Events.brunch, minutes: info.brunch)
            self.setReminder(event: Events.secondBrunch, minutes: info.secondBrunch)
            self.setReminder(event: Events.secondDaySleep, minutes: info.secondDaySleep)
            self.setReminder(event: Events.eveningMeal, minutes: info.eveningMeal)
            self.setReminder(event: Events.nightSleep, minutes: info.nightSleep)
            self.setReminder(event: Events.nightMeal, minutes: info.nightMeal)
        }
    }

    private func setReminder(event: Events, minutes: Int) {
        var date = DateComponents()
        let tmp = Converter.getHoursAndMinutesFromString(totalMinutes: minutes)
        date.hour = tmp.hours
        date.minute = tmp.minutes
        let reminder = Reminder(reminderType: .calendar, date: date, repeats: true)
        NotificationManager.shared.scheduleNotification(task: Task(name: event.rawValue, reminder: reminder))
    }
    
}
