import Foundation

struct Task {
    let id = UUID().uuidString
    let name: String
    let reminder: Reminder
}

enum ReminderType {
    case time
    case calendar
}

struct Reminder {
    var reminderType: ReminderType = .time
    var timeInterval: TimeInterval?
    var date: DateComponents?
    var repeats: Bool = false
}
