import Foundation


protocol ViewModelType {
    associatedtype Output
    func transform() -> Output
}
