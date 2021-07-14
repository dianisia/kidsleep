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
            name: UserDefaults.standard.string(forKey: "name") ?? "" ,
            birthday: UserDefaults.standard.string(forKey: "birthday") ?? "",
            breakfast: UserDefaults.standard.string(forKey: "breakfast") ?? "",
            firstDaySleep: UserDefaults.standard.string(forKey: "firstDaySleep") ?? "",
            dinner: UserDefaults.standard.string(forKey: "dinner") ?? "",
            brunch: UserDefaults.standard.string(forKey: "brunch") ?? "",
            secondDaySleep: UserDefaults.standard.string(forKey: "secondDaySleep") ?? "",
            secondBrunch: UserDefaults.standard.string(forKey: "secondBrunch") ?? "",
            eveningMeal: UserDefaults.standard.string(forKey: "eveningMeal") ?? "",
            nightSleep: UserDefaults.standard.string(forKey: "nightSleep") ?? "",
            nightMeal: UserDefaults.standard.string(forKey: "nightMeal") ?? ""
        )
    }
    
}
