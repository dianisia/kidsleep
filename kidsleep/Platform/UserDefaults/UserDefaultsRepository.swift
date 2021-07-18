import Foundation

class UserDefaultsRepository: Repository {
    func save(info: UserInfo) {
        UserDefaults.standard.setValue(info.name, forKey: "name")
        UserDefaults.standard.setValue(info.birthday, forKey: "birthday")
        let eventsData = try! JSONEncoder().encode(info.events)
        UserDefaults.standard.setValue(eventsData, forKey: "events")
    }
    
    func get() -> UserInfo {
        let eventsData = UserDefaults.standard.object(forKey: "events")
        let events: [UserEvent] = try! JSONDecoder().decode([UserEvent].self, from: eventsData as! Data)
        return UserInfo(
            name: UserDefaults.standard.string(forKey: "name") ?? "",
            birthday: UserDefaults.standard.string(forKey: "birthday") ?? "",
            gender: UserDefaults.standard.integer(forKey: "gender"),
            events: events
        )
    }
    
}
