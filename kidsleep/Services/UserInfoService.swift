import Foundation
import RxSwift

extension UserDefaultsKey {
    static var name: Key<String> { return "name" }
    static var birthday: Key<String> { return "birthday" }
    static var gender: Key<Int> { return "gender" }
    static var breakfast: Key<Int> { return "breakfast" }
    static var firstDaySleep: Key<Int> { return "firstDaySleep" }
    static var dinner: Key<Int> { return "dinner" }
    static var brunch: Key<Int> { return "brunch" }
    static var secondDaySleep: Key<Int> { return "secondDaySleep" }
    static var secondBrunch: Key<Int> { return "secondBrunch" }
    static var eveningMeal: Key<Int> { return "eveningMeal" }
    static var nightSleep: Key<Int> { return "nightSleep" }
    static var nightMeal: Key<Int> { return "nightMeal" }
}

protocol UserInfoServiceType {
    func get() -> Observable<UserInfo>
    
    @discardableResult
    func save(_ userInfo: UserInfo) -> Observable<Void>
    
}

final class UserInfoService: BaseService, UserInfoServiceType {
    func get() -> Observable<UserInfo> {
        let userInfo = UserInfo(
            name: provider.userDefaultsService.value(forKey: .name) ?? "",
            birthday: provider.userDefaultsService.value(forKey: .birthday) ?? "",
            gender: provider.userDefaultsService.value(forKey: .gender) ?? 0,
            breakfast: provider.userDefaultsService.value(forKey: .breakfast) ?? 0,
            firstDaySleep: provider.userDefaultsService.value(forKey: .firstDaySleep) ?? 0,
            dinner: provider.userDefaultsService.value(forKey: .dinner) ?? 0,
            brunch: provider.userDefaultsService.value(forKey: .brunch) ?? 0,
            secondDaySleep: provider.userDefaultsService.value(forKey: .secondDaySleep) ?? 0,
            secondBrunch: provider.userDefaultsService.value(forKey: .secondBrunch) ?? 0,
            eveningMeal: provider.userDefaultsService.value(forKey: .eveningMeal) ?? 0,
            nightSleep: provider.userDefaultsService.value(forKey: .nightSleep) ?? 0,
            nightMeal: provider.userDefaultsService.value(forKey: .nightMeal) ?? 0
        )
        return .just(userInfo)
    }
    
    func save(_ userInfo: UserInfo) -> Observable<Void> {
        provider.userDefaultsService.set(userInfo.name, forKey: .name)
        provider.userDefaultsService.set(userInfo.birthday, forKey: .birthday)
        
        provider.userDefaultsService.set(userInfo.breakfast, forKey: .breakfast)
        provider.userDefaultsService.set(userInfo.brunch, forKey: .brunch)
        provider.userDefaultsService.set(userInfo.dinner, forKey: .dinner)
        provider.userDefaultsService.set(userInfo.firstDaySleep, forKey: .firstDaySleep)
        provider.userDefaultsService.set(userInfo.eveningMeal, forKey: .eveningMeal)
        provider.userDefaultsService.set(userInfo.nightMeal, forKey: .nightMeal)
        provider.userDefaultsService.set(userInfo.nightSleep, forKey: .nightSleep)
        provider.userDefaultsService.set(userInfo.secondBrunch, forKey: .secondBrunch)
        provider.userDefaultsService.set(userInfo.secondDaySleep, forKey: .secondDaySleep)
        
        return .just(Void())
    }
    
    func getDefaultUserInfo() -> UserInfo {
        let emptyUser = UserInfo(name: "", birthday: "", gender: 0, breakfast: 0, firstDaySleep: 0, dinner: 0, brunch: 0, secondDaySleep: 0, secondBrunch: 0, eveningMeal: 0, nightSleep: 0, nightMeal: 0)
        return emptyUser
    }
}
