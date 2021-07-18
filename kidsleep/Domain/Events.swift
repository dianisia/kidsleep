import Foundation

enum EventType: String, Codable {
    case food = "food"
    case sleep = "sleep"
}

class UserEvent: Codable {
    var title: String = ""
    var value: Int
    var type: EventType?
    init(value: Int) {
        self.value = value
    }
}

class BreakfastEvent: UserEvent {
    static let title = "Завтрак"
    static let type = EventType.food
}

class FirstDaySleepEvent: UserEvent {
    static let title = "1-й дневной сон"
    static let type = EventType.sleep
}

class DinnerEvent: UserEvent {
    static let title = "1-й дневной сон"
    static let type = EventType.sleep
}

class BrunchEvent: UserEvent {
    static let title = "Полдник"
    static let type = EventType.food
}

class SecondDaySleepEvent: UserEvent {
    static let title = "2-й дневной сон"
    static let type = EventType.sleep
}

class secondBrunchEvent: UserEvent {
    static let title = "2-й полдник"
    static let type = EventType.food
}

class EveningMealEvent: UserEvent {
    static let title = "Ужин"
    static let type = EventType.food
}

class NightSleepEvent: UserEvent {
    static let title = "Ночной сон"
    static let type = EventType.sleep
}

class NightMealEvent: UserEvent {
    static let title = "Ночное кормление"
    static let type = EventType.food
}
