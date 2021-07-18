import Foundation
import RxSwift
import RxCocoa

final class OnboardingViewModel {
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
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func save() {
        let info = UserInfo(
            name: try! name.value(),
            birthday: try! birthday.value(),
            gender: try! gender.value(),
            breakfast: timeStringToMinutes(time: try! breakfast.value()),
            firstDaySleep: timeStringToMinutes(time: try! firstDaySleep.value()),
            dinner:  timeStringToMinutes(time: try! dinner.value()),
            brunch: timeStringToMinutes(time: try! brunch.value()),
            secondDaySleep: timeStringToMinutes(time: try! secondDaySleep.value()),
            secondBrunch: timeStringToMinutes(time: try! secondBrunch.value()),
            eveningMeal: timeStringToMinutes(time: try! eveningMeal.value()),
            nightSleep: timeStringToMinutes(time: try! nightSleep.value()),
            nightMeal: timeStringToMinutes(time: try! nightMeal.value())
        )
        repository.save(info: info)
        OnboardingManager.shared.setOnboarded()
    }

    private func setReminders() {
        var date = DateComponents()
        date.hour = 18
        date.minute = 20
        let reminder = Reminder(reminderType: .calendar, date: date, repeats: false)
        NotificationManager.shared.scheduleNotification(task: Task(name: "Test 18 20", reminder: reminder))
        
        NotificationManager.shared.requestAuthorization() { granted in
            print(granted)
        }
//        let reminder = Reminder(reminderType: .time, timeInterval: TimeInterval(10), repeats: false)
//        NotificationManager.shared.scheduleNotification(task: Task(name: "Test", reminder: reminder))
    }
    
}
