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
        NotificationManager.shared.requestAuthorization() { granted in
            print(granted)
            self.setReminder(event: Events.breakfast, minutes: info.breakfast)
            self.setReminder(event: Events.firstDaySleep, minutes: info.firstDaySleep)
            self.setReminder(event: Events.dinner, minutes: info.dinner)
            self.setReminder(event: Events.brunch, minutes: info.brunch)
            self.setReminder(event: Events.secondDaySleep, minutes: info.secondDaySleep)
            self.setReminder(event: Events.secondBrunch, minutes: info.secondBrunch)
            self.setReminder(event: Events.secondDaySleep, minutes: info.secondDaySleep)
            self.setReminder(event: Events.eveningMeal, minutes: info.eveningMeal)
            self.setReminder(event: Events.nightSleep, minutes: info.nightSleep)
            self.setReminder(event: Events.nightMeal, minutes: info.nightMeal)
        }
    }

    private func setReminder(event: Events, minutes: Int) {
        var date = DateComponents()
        let tmp = getHoursAndMinutesFromString(totalMinutes: minutes)
        date.hour = tmp.hours
        date.minute = tmp.minutes
        let reminder = Reminder(reminderType: .calendar, date: date, repeats: false)
        NotificationManager.shared.scheduleNotification(task: Task(name: event.rawValue, reminder: reminder))
    }
    
}
