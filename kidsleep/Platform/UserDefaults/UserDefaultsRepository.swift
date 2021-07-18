import Foundation

class UserDefaultsRepository: Repository {
    func save(info: UserInfo) {
        UserDefaults.standard.setValue(info.name, forKey: "name")
        UserDefaults.standard.setValue(info.birthday, forKey: "birthday")
        UserDefaults.standard.setValue(info.breakfast, forKey: "breakfast")
        UserDefaults.standard.setValue(info.brunch, forKey: "brunch")
        UserDefaults.standard.setValue(info.dinner, forKey: "dinner")
        UserDefaults.standard.setValue(info.firstDaySleep, forKey: "firstDaySleep")
        UserDefaults.standard.setValue(info.eveningMeal, forKey: "eveningMeal")
        UserDefaults.standard.setValue(info.nightMeal, forKey: "nightMeal")
        UserDefaults.standard.setValue(info.nightSleep, forKey: "nightSleep")
        UserDefaults.standard.setValue(info.secondBrunch, forKey: "secondBrunch")
        UserDefaults.standard.setValue(info.secondDaySleep, forKey: "secondDaySleep")
    }
    
    func get() -> UserInfo {
        return UserInfo(
            name: UserDefaults.standard.string(forKey: "name") ?? "",
            birthday: UserDefaults.standard.string(forKey: "birthday") ?? "",
            gender: UserDefaults.standard.integer(forKey: "gender"),
            breakfast: UserDefaults.standard.integer(forKey: "breakfast"),
            firstDaySleep: UserDefaults.standard.integer(forKey: "firstDaySleep"),
            dinner: UserDefaults.standard.integer(forKey: "dinner"),
            brunch: UserDefaults.standard.integer(forKey: "brunch"),
            secondDaySleep: UserDefaults.standard.integer(forKey: "secondDaySleep"),
            secondBrunch: UserDefaults.standard.integer(forKey: "secondBrunch"),
            eveningMeal: UserDefaults.standard.integer(forKey: "eveningMeal"),
            nightSleep: UserDefaults.standard.integer(forKey: "nightSleep"),
            nightMeal: UserDefaults.standard.integer(forKey: "nightMeal")
        )
    }
    
}
