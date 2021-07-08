import Foundation
import RxSwift
import RxCocoa

struct Story {
    let text: String
}

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
        stories.accept([Story(text: "Text 1"), Story(text: "Text 2"), Story(text: "Text 3")])
    }
}
