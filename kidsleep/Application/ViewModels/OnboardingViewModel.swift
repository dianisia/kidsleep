import Foundation
import RxSwift
import RxCocoa

final class OnboardingViewModel {
    private let disposeBag = DisposeBag()
    private var repository: Repository
    
    let name = BehaviorSubject<String>(value: "")
    let birthday = BehaviorSubject<String>(value: "")
    let gender = BehaviorSubject<Int>(value: 0)
    let events = BehaviorSubject<[UserEvent]>(value: [])
  
    init(repository: Repository) {
        self.repository = repository
    }
    
    func save() {
        let info = UserInfo(
            name: try! name.value(),
            birthday: try! birthday.value(),
            gender: try! gender.value(),
            events: try! events.value()
        )
        repository.save(info: info)
        OnboardingManager.shared.setOnboarded()
        NotificationManager.shared.requestAuthorization() { granted in
            for event in info.events {
                self.setReminder(event: event.title, minutes: event.value)
            }
        }
    }

    private func setReminder(event: String, minutes: Int) {
        var date = DateComponents()
        let tmp = getHoursAndMinutesFromString(totalMinutes: minutes)
        date.hour = tmp.hours
        date.minute = tmp.minutes
        let reminder = Reminder(reminderType: .calendar, date: date, repeats: true)
        NotificationManager.shared.scheduleNotification(task: Task(name: event, reminder: reminder))
    }
    
}
