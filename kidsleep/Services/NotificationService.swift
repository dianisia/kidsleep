import Foundation
import UserNotifications

protocol NotificationServiceType {
    func requestAuthorization(completion: @escaping (Bool) -> Void)
    func scheduleNotification(task: NotificationTask)
}

class NotificationService: NotificationServiceType {
    static let shared = NotificationService()
    var settings: UNNotificationSettings?
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                granted, _ in
                self.fetchNotificationSettings()
                completion(granted)
            }
    }
    
    private func fetchNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.settings = settings
            }
        }
    }
    
    func scheduleNotification(task: NotificationTask) {
        let content = UNMutableNotificationContent()
        content.title = task.name
        content.body = "Совсем скоро \(task.name.lowercased())"
        
        var trigger: UNNotificationTrigger?
        switch task.reminder.reminderType {
        case .time:
            if let timeInterval = task.reminder.timeInterval {
                trigger = UNTimeIntervalNotificationTrigger(
                    timeInterval: timeInterval,
                    repeats: task.reminder.repeats)
            }
        case .calendar:
            if let date = task.reminder.date {
                trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: task.reminder.repeats)
            }
        }
        
        if let trigger = trigger {
            let request = UNNotificationRequest(
                identifier: task.id,
                content: content,
                trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print(error)
                }
            }
        }
    }
}
