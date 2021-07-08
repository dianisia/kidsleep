import Foundation
import RxSwift
import RxCocoa

class StoriesViewModel {
    private var stories = BehaviorRelay<[Story]>(value: [])
    struct Input {

    }
    
    struct Output {
        let stories: Observable<[Story]>
    }
    
    func transform(input: Input) -> Output {
        requestStories()
        return Output(stories: stories.asObservable())
    }
    
    private func requestStories() {
        APICaller.shared.getStories {[unowned self] error, result in
            guard error == nil, let result = result, result.count > 0 else {
                return stories.accept([])
            }
            stories.accept(result)
        }
    }
}
