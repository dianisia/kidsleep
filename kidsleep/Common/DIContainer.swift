import Foundation

final class DIContainer {
    static func getRepository() -> Repository {
        return UserDefaultsRepository()
    }
}
