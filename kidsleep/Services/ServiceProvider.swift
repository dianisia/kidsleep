
protocol ServiceProviderType: AnyObject {
    var userDefaultsService: UserDefaultsServiceType { get }
    var apiService: APIServiceType { get }
    var userInfoService: UserInfoServiceType { get }
    var notificationService: NotificationServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var userDefaultsService: UserDefaultsServiceType = UserDefaultsService(provider: self)
    lazy var apiService: APIServiceType = APIService.shared
    lazy var userInfoService: UserInfoServiceType = UserInfoService(provider: self)
    lazy var notificationService: NotificationServiceType = NotificationService()
}
