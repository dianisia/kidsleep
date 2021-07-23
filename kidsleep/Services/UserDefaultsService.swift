import Foundation

struct UserDefaultsKey<T> {
  typealias Key<T> = UserDefaultsKey<T>
  let key: String
}

extension UserDefaultsKey: ExpressibleByStringLiteral {
  public init(unicodeScalarLiteral value: StringLiteralType) {
    self.init(key: value)
  }

  public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
    self.init(key: value)
  }

  public init(stringLiteral value: StringLiteralType) {
    self.init(key: value)
  }
}

protocol UserDefaultsServiceType {
    func value<T>(forKey key: UserDefaultsKey<T>) -> T?
    func set<T>(_ value: T?, forKey key: UserDefaultsKey<T>)
}

final class UserDefaultsService: BaseService, UserDefaultsServiceType {
    
    private var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    func value<T>(forKey key: UserDefaultsKey<T>) -> T? {
        return self.defaults.value(forKey: key.key) as? T
    }
    
    func set<T>(_ value: T?, forKey key: UserDefaultsKey<T>) {
        self.defaults.set(value, forKey: key.key)
        self.defaults.synchronize()
    }
}
