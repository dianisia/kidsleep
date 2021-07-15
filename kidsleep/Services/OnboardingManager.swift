import Foundation


final class OnboardingManager {
    static let shared = OnboardingManager()
    var isOnboarded: Bool {
        UserDefaults.standard.string(forKey: "isOnboarded") != nil
    }
    
    public func setOnboarded() {
        UserDefaults.standard.setValue(true, forKey: "isOnboarded")
    }
}
